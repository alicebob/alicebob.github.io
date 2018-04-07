{
	"template": "../page.template", 
	"entry": false
}
---
## Blogs!

<ul>
{{ range sorted .files.b }}
	{{ if .entry }}
		<li><a href="{{ relative .url }}">{{ .title }}</a></li>
	{{ end }}
{{ end }}
</ul>
