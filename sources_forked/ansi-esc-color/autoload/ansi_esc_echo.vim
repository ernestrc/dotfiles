"▶1 
scriptencoding utf-8
execute frawor#Setup('0.0', {'@/resources': '0.0',
            \                  '@/options': '0.0',
            \                       '@/os': '0.0',})
let s:r={}
let s:_options={
            \'color_file': {'default': s:_r.os.path.join(s:_frawor.runtimepath,
            \                                            'config',
            \                                            'ansi_esc_echo',
            \                                            'colors.yaml'),
            \                'scopes': 'g',
            \               'checker': 'either (is=(0) path)'},
        \}
let s:_messages={
            \'misscol': 'Color file is missing',
        \}
"▶1 Get colors
if has('gui_running')
    let s:pref='gui'
    let s:colorfile=s:_f.getoption('color_file')
    if !filereadable(s:colorfile)
        call s:_f.warn('misscol')
    else
        let s:colors=map(filter(readfile(s:colorfile, 'b'), 'v:val[:1]==#"- "'),
                    \    'v:val[3:9]')
    endif
    function s:F.getcolor(key, spec)
        return 'gui'.a:key.'='.((type(a:spec)==type(0))?
                    \               get(s:colors, a:spec, 'NONE'):
                    \               a:spec)
    endfunction
else
    let s:pref='cterm'
    function s:F.getcolor(key, spec)
        return 'cterm'.a:key.'='.a:spec
    endfunction
endif
"▶1 addtext
function s:F.addtext(lines, text)
    if a:lines.col==len(a:lines.cur.line)
        let a:lines.cur.line.=a:text
        let a:lines.col+=len(a:text)
    else
        let startwidth=strdisplaywidth(a:lines.cur.line[:(a:lines.col)])
        let removewidth=0
        let removelen=0
        let textwidth=strdisplaywidth(a:text, startwidth)
        while removewidth<textwidth
            let char=matchstr(a:lines.cur.line, '.', a:lines.col)
            let removewidth+=strdisplaywidth(char, startwidth+removewidth)
            let removelen+=len(char)
        endwhile
        let a:lines.cur.line=((a:lines.col)?
                    \               (a:lines.cur.line[:(a:lines.col-1)]):
                    \               ('')).
                    \        a:text.
                    \        a:lines.cur.line[(a:lines.col+removelen):]
        let a:lines.col+=len(a:text)
    endif
endfunction
"▶1 textdisplaywidth
function s:F.textdisplaywidth(lines)
    return strdisplaywidth(a:lines.cur.line[:(a:lines.col-1)])
endfunction
"▶1 lastcolor
function s:F.lastcolor(lines)
    return a:lines.cur.revert.colors[
                \max(filter(keys(a:lines.cur.revert.colors),
                \           'v:val<='.a:lines.col))]
endfunction
"▶1 setcol
function s:F.setcol(lines, col)
    let a:lines.cur.reverts[-1].to=a:lines.col
    let a:lines.cur.reverts+=[{'colors': {a:col : s:F.lastcolor(a:lines)},
                \                         'from': a:col}]
    let a:lines.cur.revert=a:lines.cur.reverts[-1]
    let a:lines.col=a:col
endfunction
"▶1 ctl
let s:ctl={}
"▶2 Start of heading
function s:ctl.x01(lines)
endfunction
"▶2 Start of text
function s:ctl.x02(lines)
endfunction
"▶2 Backspace
function s:ctl.x08(lines)
    if a:lines.col
        let colshift=len(matchstr(a:lines.cur.line[:(a:lines.col-1)], '.$'))
        call s:F.setcol(a:lines, a:lines.col-colshift)
    endif
endfunction
"▶2 Tab
function s:ctl.x09(lines)
    call s:F.addtext(a:lines,
                \    repeat(' ', 8-s:F.textdisplaywidth(a:lines)/8))
endfunction
"▶2 New line
function s:ctl.x0A(lines)
    if len(a:lines.lines)==a:lines.line+1
        let a:lines.lines+=[{'line': '',
                    \        'reverts': [{'colors':
                    \                         {'0': s:F.lastcolor(a:lines)},
                    \                     'from': 0}]}]
    endif
    let a:lines.cur.revert.to=a:lines.col
    let a:lines.col=0
    let a:lines.line+=1
    let a:lines.cur=a:lines.lines[a:lines.line]
    let a:lines.cur.revert=a:lines.cur.reverts[-1]
endfunction
"▶2 Carriage return
function s:ctl.x0D(lines)
    call s:F.setcol(a:lines, 0)
endfunction
"▶2 Shift out
function s:ctl.x0E(lines)
endfunction
"▶2 Shift in
function s:ctl.x0F(lines)
endfunction
"▶1 col_to_hl
let s:hls={}
function s:F.col_to_hl(color)
    let hl='ANSIColor_'.get(a:color, 'fg', '').'_'.
                \       get(a:color, 'bg', '').'_'.
                \       join(sort(get(a:color, 'fattrs', [])), '_')
    if !has_key(s:hls, hl)
        let cmd='hi '.hl.' '
        for key in filter(['fg', 'bg'], 'has_key(a:color, v:val)')
            let cmd.=' '.s:F.getcolor(key, a:color[key])
        endfor
        if has_key(a:color, 'fattrs') && !empty(a:color.fattrs)
            let cmd.=' '.s:pref.'='.join(a:color.fattr, ',')
        endif
        execute cmd
        let s:hls[hl]=1
    endif
    return hl
endfunction
"▶1 get_color
function s:F.get_color(lastcolor, curcolor)
    let r={}
    if has_key(a:curcolor, 'hl')
        let r.hl=a:curcolor.hl
    elseif empty(a:curcolor)
        let r.hl='None'
    else
        for key in ['fg', 'bg']
            if has_key(a:curcolor, key)
                let r[key]=a:curcolor[key]
            elseif has_key(a:lastcolor, key)
                let r[key]=a:lastcolor[key]
            endif
        endfor
        if has_key(a:lastcolor, 'fattrs')
            let r.fattrs=copy(a:lastcolor.fattrs)
        else
            let r.fattrs=[]
        endif
        if has_key(a:curcolor, 'fattr')
            if a:curcolor.fattr[0] is# '-'
                call filter(r.fattrs, 'v:val isnot# "'.a:curcolor.fattr[1:].'"')
            elseif index(r.fattrs, a:curcolor.fattr)==-1
                let r.fattrs+=[a:curcolor.fattr]
            endif
        endif
        let r.hl=s:F.col_to_hl(r)
    endif
    return r
endfunction
"▶1 set_color
function s:F.set_color(lines, color)
    let a:lines.cur.revert.colors[a:lines.col]=
                \extend(filter(copy(get(a:lines.cur.revert.colors,
                \                       a:lines.col, {})),
                \              'v:key isnot# "hl"'),
                \       filter(copy(a:color), 'v:key isnot# "normal"'))
endfunction
"▶1 csi
let s:csi={}
"▶2 Font
let s:font={
            \  0: {'normal': 1, 'hl': 'None'},
            \  1: {'normal': 0, 'fattr': 'bold'},
            \  4: {'normal': 0, 'fattr': 'underline'},
            \  5: {'normal': 0, 'fattr': 'bold'},
            \  7: {'normal': 0, 'fattr': 'reverse'},
            \  8: {'normal': 0, 'hl': 'Ignore'},
            \ 22: {'normal': 1, 'fattr': '-bold'},
            \ 24: {'normal': 1, 'fattr': '-underline'},
            \ 25: {'normal': 1, 'fattr': '-bold'},
            \ 27: {'normal': 1, 'fattr': '-reverse'},
            \ 28: {'normal': 1, 'fg': 'none', 'bg': 'none'},
            \ 30: {'normal': 0, 'fg': 16},
            \ 31: {'normal': 0, 'fg':  1},
            \ 32: {'normal': 0, 'fg':  2},
            \ 33: {'normal': 0, 'fg':  3},
            \ 34: {'normal': 0, 'fg':  4},
            \ 35: {'normal': 0, 'fg':  5},
            \ 36: {'normal': 0, 'fg':  6},
            \ 37: {'normal': 0, 'fg':  7},
            \ 39: {'normal': 1, 'fg': 'none'},
            \ 40: {'normal': 0, 'bg': 16},
            \ 41: {'normal': 0, 'bg':  1},
            \ 42: {'normal': 0, 'bg':  2},
            \ 43: {'normal': 0, 'bg':  3},
            \ 44: {'normal': 0, 'bg':  4},
            \ 45: {'normal': 0, 'bg':  5},
            \ 46: {'normal': 0, 'bg':  6},
            \ 47: {'normal': 0, 'bg':  7},
            \ 49: {'normal': 1, 'bg': 'none'},
            \ 90: {'normal': 0, 'fg':  8},
            \ 91: {'normal': 0, 'fg':  9},
            \ 92: {'normal': 0, 'fg': 10},
            \ 93: {'normal': 0, 'fg': 11},
            \ 94: {'normal': 0, 'fg': 12},
            \ 95: {'normal': 0, 'fg': 13},
            \ 96: {'normal': 0, 'fg': 14},
            \ 97: {'normal': 0, 'fg': 15},
            \100: {'normal': 0, 'fg':  8},
            \101: {'normal': 0, 'fg':  9},
            \102: {'normal': 0, 'fg': 10},
            \103: {'normal': 0, 'fg': 11},
            \104: {'normal': 0, 'fg': 12},
            \105: {'normal': 0, 'fg': 13},
            \106: {'normal': 0, 'fg': 14},
            \107: {'normal': 0, 'fg': 15},
        \}
function s:csi.m(lines, attr)
    if empty(a:attr.vals)
        let a:attr.vals=[0]
    endif
    let lvals=len(a:attr.vals)
    if lvals==3 && a:attr.vals[0]==38 && a:attr.vals[1]==5
        call s:F.set_color(a:lines, {'fg': a:attr.vals[2]})
    elseif lvals==3 && a:attr.vals[0]==48 && a:attr.vals[1]==5
        call s:F.set_color(a:lines, {'bg': a:attr.vals[2]})
    else
        for font in map(filter(copy(a:attr.vals),
                    \          'has_key(s:font, v:val)'),
                    \   's:font[v:val]')
            call s:F.set_color(a:lines, font)
        endfor
    endif
endfunction
"▶2 clear_screen
function s:csi.J(lines, attr)
endfunction
"▶2 clear_line
function s:csi.K(lines, attr)
endfunction
"▶2 add_spaces
function s:csi.at(lines, attr)
endfunction
let s:csi['@']=remove(s:csi, 'at')
"▶2 cursor_up
function s:csi.A(lines, attr)
endfunction
"▶2 cursor_down
function s:csi.B(lines, attr)
endfunction
"▶2 cursor_left
function s:csi.D(lines, attr)
endfunction
"▶2 cursor_to_column
function s:csi.G(lines, attr)
endfunction
"▶2 cursor
function s:csi.H(lines, attr)
endfunction
let s:csi.f=s:csi.H
"▶2 delete_chars
function s:csi.P(lines, attr)
endfunction
"▶2 tab_clear
function s:csi.g(lines, attr)
endfunction
"▶2 set_coords
function s:csi.r(lines, attr)
endfunction
"▶2 set
function s:csi.h(lines, attr)
endfunction
"▶2 reset
function s:csi.l(lines, attr)
endfunction
"▶1 parse_csi
function s:F.parse_csi(lines, chunk)
    let attr={'key': a:chunk[-1:], 'flag': '', 'val': 1, 'vals': []}
    if !has_key(s:csi, attr.key)
        return
    endif
    if len(a:chunk)==1
        call s:csi[attr.key](a:lines, attr)
        return
    endif
    let full=a:chunk[:-2]
    if full[0] is# '?'
        let full=full[1:]
        let attr.flag='?'
    endif
    if !empty(full)
        let attr.vals=map(split(full, ';'), 'str2nr(v:val)')
    endif
    if len(attr.vals)==1
        let attr.val=attr.vals[0]
    endif
    call s:csi[attr.key](a:lines, attr)
endfunction
"▶1 s:NumCmp
function s:NumCmp(a, b)
    let a=+a:a
    let b=+a:b
    return ((a>b)-(a<b))
endfunction
let s:_functions+=['s:NumCmp']
"▶1 echo
function s:F.echo(lines)
    let prevcolors=[]
    let i=0
    for text in a:lines.lines
        if i
            echon "\n"
        endif
        let i+=1
        let prevcol=0
        let colors={}
        let rreverts=reverse(copy(text.reverts))
        let lline=len(text.line)
        let col=0
        let prevcolors=[[get(prevcolors, -1, [{}])[0], lline]]
        while col<=lline
            if col<lline
                while prevcolors[-1][1]<=col
                    call remove(prevcolors, -1)
                endwhile
            endif
            for revert in rreverts
                if revert.from<=col && (!has_key(revert, 'to') || revert.to>col)
                    let color=revert.colors[
                                \max(filter(keys(revert.colors),'v:val<='.col))]
                    let to=get(revert, 'to', lline)
                    break
                endif
            endfor
            let color=s:F.get_color(prevcolors[-1][0], color)
            if color!=#prevcolors[-1][0]
                let colors[col]=color
                let prevcolors+=[[color, to]]
            endif
            let col+=max([len(matchstr(text.line, '.', col)), 1])
        endwhile
        for col in sort(keys(colors), 's:NumCmp')
            let color=colors[col]
            if col
                echon text.line[(prevcol):(col-1)]
            endif
            execute 'echohl '.color.hl
            let prevcol=col
        endfor
        if prevcol<len(text.line)
            echon text.line[(prevcol):]
        endif
    endfor
    echohl None
    return get(prevcolors, -1, [{}])[0]
endfunction
"▶1 r.echo
let s:csi_start="\e["
let s:seq_reg='(\e\[?\??#?[0-9;]*[a-zA-Z@=>]|'.
            \  '\e\]\d;.{-}\x07|'.
            \  '[\x01-\x0f]|'.
            \  '\e\([AB0])'
let s:seq_reg='\v'.s:seq_reg.'@<=|'.s:seq_reg.'@='
function s:r.echo(str, ...)
    if type(a:str)==type([])
        let chunks=[]
        call map(copy(a:str),
                    \'extend('.
                    \   'chunks, '.
                    \   '(v:key ? ["\n"] : [])+'.
                    \   'split('.
                    \       'substitute(v:val, "\n", "", "g"), '.
                    \       's:seq_reg))')
    else
        let chunks=split(a:str, s:seq_reg)
    endif
    let lines={'lines':[{'line': '',
                \        'reverts':[{'colors':{'0':get(a:000,0,{'hl': 'None'})},
                \                     'from': 0,}]}],
                \'line': 0, 'col': 0}
    let lines.cur=lines.lines[-1]
    let lines.cur.revert=lines.cur.reverts[-1]
    for chunk in chunks
        if chunk<="\x0F"
            let e=printf('x%02X', char2nr(chunk))
            if has_key(s:ctl, e)
                call s:ctl[e](lines)
            endif
        elseif chunk[:1] is# "\e["
            call s:F.parse_csi(lines, chunk[2:])
        elseif chunk[:1] is# "\e]"
            " Changing title: do nothing
        elseif chunk[:1] is# "\e#"
            " Hash: do nothing
        elseif chunk[0] is# "\e" && stridx('()', chunk[1])!=-1
            " TODO? charset
        elseif chunk[0] is# "\e" && len(chunk)==2
            " TODO? esc_scroll_up, esc_next_line, esc_set_tab, esc_scroll_down
        else
            call s:F.addtext(lines, chunk)
        endif
    endfor
    return s:F.echo(lines)
endfunction
"▶1 post resource
call s:_f.postresource('ansi_esc', s:r)
unlet s:r
"▶1 
call frawor#Lockvar(s:, 'hls')
" vim: ft=vim tw=4 ts=4 sts=4 et tw=80 fmr=▶,▲
