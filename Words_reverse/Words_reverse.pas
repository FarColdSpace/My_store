program PrintWordsReverse;

type
	exprptr = ^expression;
	letterptr = ^letter;

	letter = record
		next: letterptr;
		symbol: char;
	end;

	expression = record
		next: exprptr;
		letters: letterptr;
	end;	
var
	tmpexpr, currexpr: exprptr;
	tmpletter, currletter: letterptr;
	inpchar: char;
	lastsymb: boolean;

procedure NewWord(var tmpexpr, currexpr: exprptr; var tmpletter, currletter: letterptr; inpchar :char);

begin
	new(tmpexpr);
	tmpexpr^.next := currexpr;
	new(tmpletter);
	tmpexpr^.letters := tmpletter;
	currletter := tmpletter;
	tmpexpr^.letters^.symbol := inpchar;
	tmpexpr^.letters^.next := nil;
	currexpr := tmpexpr;
end;

procedure WriteLetter(inpchar: char; var tmpletter, currletter: letterptr);
begin
	new(tmpletter);
	currletter^.next := tmpletter;
	currletter := tmpletter;
	currletter^.next := nil;
	currletter^.symbol := inpchar; 
end;
begin
	currexpr := nil;
	lastsymb := false;
	while not Eof do
	begin
		read(inpchar);
		if (((inpchar >= 'a') and (inpchar  <= 'z'))	or
	 	((inpchar >= 'A') and (inpchar  <= 'Z')) or (inpchar = '''') ) then
		begin
			if lastsymb then
				WriteLetter(inpchar, tmpletter, currletter)
			else
			begin
				NewWord(tmpexpr, currexpr, tmpletter, currletter, inpchar);
				lastsymb := true;
			end;
		end
		else
		begin		
			lastsymb := false;
		end;
	end;

	while not (currexpr = nil) do
	begin		
		currletter := currexpr^.letters;
		tmpletter := currexpr^.letters;
		while not (currletter = nil) do
		begin		
			write(currletter^.symbol);
			tmpletter := currletter;
			currletter := currletter^.next;
			dispose(tmpletter);
		end;
		tmpexpr := currexpr;
		currexpr := currexpr^.next;
		dispose(tmpexpr);
		write(' ');
	end;
	writeln('');
end.		
