( ( window, $ ) ->

	class TabIndent
	
		@version:	"0.1.0"
		@newLine:	/\n/
		@autobind:	( selector = ".tabIndent" ) ->
			
			if typeof selector == "string"
					
				$( document.body ).on "focus.tabIndent", selector, ( e ) =>
					
					$el = $ e.currentTarget
					
					unless $el.data( 'tabIndent' )
						$el.data 'tabIndent', new @({ el: $el })
						
				return @
							
			else
			
				throw new SyntaxError "Invalid selector."

		@unautobind: ( selector = ".tabIndent" ) ->
			
			if typeof selector == "string"
					
				$( document.body ).off "focus.tabIndent", selector
				
				return @
							
			else
			
				throw new SyntaxError "Invalid selector."
				
		constructor: ( params ) ->
		
			@params 	= params
			@$el		= params.el
			@el			= params.el.get 0
			
			@bindEvents()
			
		bindEvents: ->
	
			@$el.off "focus.tabIndent", => @bindEvents()
			@$el.on "keydown.tabIndent", ( e ) =>
				
				current =
					start:	@el.selectionStart
					end:	@el.selectionEnd
					
				if e.keyCode == 9 || ( e.keyCode == 221 && e.metaKey )
				
					# indent
					
					e.preventDefault()
					
					if @isMultiLine()
					
						startIndices	= @findStartIndices()
						length			= startIndices.length
						newCurrent		= start: undefined, end: undefined
						affectedRows	= 0
						
						while length--
						
							lowerBound = startIndices[ length ]
							
							if startIndices[ length + 1 ] && current.start != startIndices[ length + 1 ]
								lowerBound = startIndices[ length + 1 ]
								
							if lowerBound >= current.start && startIndices[ length ] < current.end
								
								@el.value = @el.value.slice( 0, startIndices[ length ] ) + "\t" + @el.value.slice( startIndices[ length ] );
								
								newCurrent.start = startIndices[ length ]
								
								if !newCurrent.end
									newCurrent.end = if startIndices[ length + 1 ] then startIndices[ length + 1 ] - 1 else 'end'
									
								affectedRows++
								
						@el.selectionStart	= newCurrent.start
						@el.selectionEnd	= if newCurrent.end != "end" then newCurrent.end + affectedRows else @el.value.length
							
					else
					
						@el.value			= @el.value.slice( 0, current.start ) + "\t" + @el.value.slice( current.start );
						@el.selectionStart	= current.start + 1
						@el.selectionEnd	= current.end + 1
						
					false
				
				else if e.keyCode == 219 && e.metaKey
					
					#indent left
					e.preventDefault()
										
					if @isMultiLine()
					
						startIndices	= @findStartIndices()
						length			= startIndices.length
						newCurrent		= start: undefined, end: undefined
						affectedRows	= 0
						
						while length--
				
							lowerBound = startIndices[ length ]
							
							if startIndices[ length + 1 ] && current.start != startIndices[ length + 1 ]
								lowerBound = startIndices[ length + 1 ]
								
							if lowerBound >= current.start && startIndices[ length ] < current.end
								
								if @el.value.substr( startIndices[ length ], 1 ) == '\t'
									
									@el.value = @el.value.slice( 0, startIndices[ length ] ) + @el.value.slice( startIndices[ length ] + 1 )
									
									affectedRows++
									
								newCurrent.start = startIndices[ length ]
								
								if !newCurrent.end	
									newCurrent.end = if startIndices[ length + 1 ] then startIndices[ length + 1 ] - 1 else "end"
	
						@el.selectionStart	= newCurrent.start
						@el.selectionEnd	= if newCurrent.end != "end" then newCurrent.end - affectedRows else @el.value.length
					
					else
					
						if @el.value.substr( current.start - 1, 1 ) == '\t'
								
							@el.value			= @el.value.substr( 0, current.start - 1 ) + @el.value.substr( current.start )
							@el.selectionStart	= current.start - 1
							@el.selectionEnd	= current.end - 1
							
						else
						
							@el.value			= @el.value.substr( 0, current.start ) + @el.value.substr( current.start + 1 )
							@el.selectionStart	= current.start
							@el.selectionEnd	= current.end - 1
	
				else if e.keyCode == 13
				
					# new line with indent
					e.preventDefault()
					
					lastLine	= @el.value.substr( 0, current.start ).split( '\n' ).pop()
					indent		= lastLine.match( /^\s*/ )[0]
				
					@el.value			= @el.value.slice( 0, current.start ) + "\n#{indent}" + @el.value.slice( current.end, @el.value.length );
					@el.selectionStart	= current.start + 1 + indent.length
					@el.selectionEnd	= @el.selectionStart
					
				else if e.keyCode == 27
				
					#unbind
					
					@unbindEvents()
					
			@$el.addClass "tabIndented"
					
		unbindEvents: ->
					
			@$el.off ".tabIndent"
			@$el.on "focus.tabIndent", => @bindEvents()
			@$el.removeClass "tabIndented"
			
		isMultiLine: ->
		
			snippet = @el.value.slice @el.selectionStart, @el.selectionEnd
			
			return TabIndent.newLine.test snippet
					
		findStartIndices: ->
		
			text			= @el.value
			startIndices	= []
			offset			= 0
			
			while text.match( TabIndent.newLine ) && text.match( TabIndent.newLine ).length > 0
			
				offset	= if startIndices.length > 0 then startIndices[ startIndices.length - 1 ] else 0
				lineEnd = text.search "\n"
				
				startIndices.push lineEnd + offset + 1
				
				text = text.substring lineEnd + 1
				
			startIndices.unshift 0
			
			return startIndices
			
	$.tabIndent		= TabIndent
	$.fn.tabIndent	= ( options ) ->
		
		@each ->
			
			$el = $ @
			
			data = $el.data 'tabIndent'
			
			if data
			
				if typeof options == "string"
					data[ options ]()
			
			else
			
				$el.data 'tabIndent', new TabIndent( $.extend( options, el: $el ) )
			
)( window, jQuery )