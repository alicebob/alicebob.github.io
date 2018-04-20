{"title":"Reworking Go table tests"}
---
<div class="date"> 
Berlin, April 2018
</div>

While working on [SQLittle](https://github.com/alicebob/sqlittle) I wrote some test in (my) usual table driven test style. The idea is to loop over test cases when testing a list of permutations, without too much boilerplate:

<pre>
func TestRecord(t *testing.T) {
    for i, cas := range []struct {
        e    string
        want []interface{}
        err  error
    }{
        {
            // type 1: 8 bit
            e:    "\x02\x01P",
            want: []interface{}{int64(80)},
        },
        {
            // type 1: 8 bit
            e:    "\x02\x01\xb0",
            want: []interface{}{-int64(80)},
        },
        {
            // type 2: 16 bit
            e:    "\x02\x02@\x00",
            want: []interface{}{int64(1 << 14)},
        },
        //  ... few pages of this ...
     } {
        e, err := parseRecord([]byte(cas.e))
        if have, want := err, cas.err; !reflect.DeepEqual(have, want) {
            t.Fatalf("case %d: have %v, want %v", i, have, want)
        }
        if have, want := e, cas.want; !reflect.DeepEqual(have, want) {
            t.Errorf("case %d: have\n-[[%#v]], want\n-[[%#v]]", i, have, want)
        }
    }
}
</pre>

Pretty good, since it's easy to add tests, with minimal new code. When a test fails you get the number of the failed entry and you can sorta figure it which one it is, but it's not great.

But, since Go 1.9 there is the <code>t.Helper()</code> function. Using that I
can rewrite the above in:

<pre>
func TestRecord(t *testing.T) {
    test := func(e string, want []interface{}, wantErr error) {
        t.Helper()
        parsed, err := parseRecord([]byte(e))
        if have, want := err, wantErr; !reflect.DeepEqual(have, want) {
            t.Fatalf("have %v, want %v", have, want)
        }
        if have, want := parsed, want; !reflect.DeepEqual(have, want) {
            t.Errorf("have\n-[[%#v]], want\n-[[%#v]]", have, want)
        }
    }
    test(
        // type 1: 8 bit
        "\x02\x01P",
        []interface{}{int64(80)},
        nil,
    )
    test(
        // type 1: 8 bit
        "\x02\x01\xb0",
        []interface{}{-int64(80)},
        nil,
    )
    // still a few pages of this
}
</pre>

Much cleaner, and when a test fails it points to the calling
<code>test()</code> function, not the <code>t.Errorf()</code> line.
