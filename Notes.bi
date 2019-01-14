'========================================================================================================================================
' Notes.bi
'========================================================================================================================================
#Define __Notes__
'========================================================================================================================================
Namespace Notes_
	'========================================================================================================================================
	Type TNoteSet 
		As String * 2 notes(any)
		As Integer count
		Declare Sub lower_note(ByRef index As Integer, ByVal half_steps As Integer = 1) 
		Declare Sub raise_note(ByRef index As Integer, ByVal half_steps As Integer = 1)  
		Declare Sub add_note(ByRef note As Const String)
		Declare Constructor(ByVal note_count As Integer)
		Declare Constructor() 
		Declare Sub dump()  
	End Type
	'--------------------------------------------------------------------------------------------------------------------------------------
		Constructor TNoteSet():End Constructor 
		Constructor TNoteSet(ByVal note_count As Integer)
			'
			ReDim notes(1 To note_count) 
		End Constructor
		'--------------------------------------------------------------------------------------------------------------------------------------
		Sub TNoteSet.add_note(ByRef note As Const String)
			'
			With This
				ReDim Preserve .notes(0 To .count)
				.count += 1 
				.notes(count - 1) = note 
				'?"ccc "; .count, .notes(count-1)
			End With  
		End Sub
		Sub TNoteSet.dump() 
			For i As Integer = 0 To this.count-1 
				? i & "> " & this.notes(i) &  " <"
			Next
		End Sub
	'========================================================================================================================================
	Dim Shared As String * 2 notes(1 To 12) = {"A ", "A#", "B ", "C ", "C#", "D ", "D#", "E ", "F ", "F#", "G ", "G#"}
	'========================================================================================================================================
	Declare Sub create_noteset(ByRef root_note As Const String, ByRef note_set As TNoteSet)
	Declare Sub get_n_notes_from_a(ByRef a As Const String, ByVal n As Integer, ret_val() As string)
	Declare Function is_valid_note(ByRef s As String) As boolean
	Declare Function get_half_step(ByRef note As Const String) As String  
	Declare Function get_whole_step(ByRef note As Const String) As String  
	Declare Function _get_note_index(ByRef note As Const String) As Integer
	Declare Function get_half_step_down(ByRef note As Const String) As String 
	'========================================================================================================================================
		Sub TNoteSEt.lower_note(ByRef index As integer, ByVal half_steps As Integer = 1)
			'
			With This 
				For i As Integer = 1 To half_steps
					Dim As String s = Notes_.get_half_step_down(notes(index))
					notes(index) = s 					 
				Next
			End With
		End Sub
		Sub TNoteSet.raise_note(ByRef index As Integer, ByVal half_steps As Integer = 1)
			'
			With This 
				For i As Integer = 1 To half_steps
					Dim As String s = Notes_.get_half_step(notes(index))
					notes(index) = s 					 
				Next
			End With
		End Sub
	'========================================================================================================================================
	Function get_half_step_down(ByRef note As Const String) As String 
		'
		Dim As Integer index = Notes_._get_note_index(note) 
		If index = 0 Then Return ""
		If index = 1 Then Return Notes_.notes(12) 
		Return notes(index - 1)  
	End Function
	Function get_half_step(ByRef note As Const String) As String 
		'
		Dim As Integer index = Notes_._get_note_index(note) 
		If index = 0 Then Return ""
		If index = 12 Then Return Notes_.notes(1) 
		Return notes(index + 1)  
	End Function
	Function get_whole_step(ByRef note As Const String) As String
		'
		Dim As Integer index = Notes_._get_note_index(note) 
		If index = 0 Then Return ""
		If index > 10 Then Return notes(1 + (1 - (12 - index)))
		Return notes(index + 2)   
	End Function
	sub create_noteset(ByRef root_note As Const String, ByRef note_set As TNoteSet)
		'
		Dim As Integer r = _get_note_index(root_note), n, count = UBound(note_set.notes) 
		If r = 0 Then 
			?"Error in "& __FUNCTION__ 
			? "Note > " & root_note & " < not found"
			Sleep 
			End   
		EndIf
			
		While n < count 
			note_set.add_note(notes(r))
			n += 1 
			r += 1 
			If r > 12 Then r = 1
		Wend
	End Sub  
	Sub get_n_notes_from_a(ByRef a As Const String, ByVal n As Integer, ret_val() As string)
		'
		
	End Sub
	Function _get_note_index(ByRef note As Const String) As Integer
		'
		For i As Integer = 1 To 12 
			Dim As String * 2 s  
			LSet s, note
			'? ">";LCase(notes(i));"<", ">";LCase(s);"<", LCase(notes(i)) = LCase(s) 			
			If LCase(notes(i)) = LCase(s) Then Return i 
		Next
		Return 0 
	End Function
 End Namespace 
