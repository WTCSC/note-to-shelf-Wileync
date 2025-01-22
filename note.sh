#!/bin/bash

# File to store notes
Notes_File="notes.txt" #Creates a variable equal to our notes.txt file
Notes_Log_File="Note_Log.txt" #Creates a variable equal to our Note_Log.txt file for the log of what happens to our notes

    # Function to add a note
    add_note() { #Starts a add_note Function
        local note_text="$1" #creates the local variable note_text
        local timestamp=$(date +"%Y-%m-%d %H:%M:%S") #creates the local variable timestamp to give us the exact time notes are added.
        echo "$timestamp - $note_text" >> "$Notes_File" #Prints the form of our note
        if [[ $? -eq 0 ]]; then #
            echo "Note added successfully" #Prints that the note was added successfully
            echo "$timestamp - Added note: $note_text" >> "$Notes_Log_File" #formats the note
        else
            echo "Error adding note" >&2 #Echos/prints Error adding note if it didn't work
            echo "$timestamp - Error adding note: $note_text" >> "$Notes_Log_File" #Puts the Error adding note in the terminal
            exit 1 #exits
        fi
    } #closes add_note function

        # Function to list all notes
        list_notes() { #Creates a function to list the notes in our file.
            if [[ -f "$Notes_File" ]]; then #If we list notes open the file
                cat "$Notes_File" #list everything in the file using cat
            else
                echo "No notes found." #if there are none, it prints/echos No notes found
            fi
        }

            # Function to search notes
            search_notes() { #creates a function to search notes
                local keyword="$1" #creates a keyword variable
                if [[ -f "$Notes_File" ]]; then #if found in the file
                    grep -i --color=always "$keyword" "$Notes_File" #Color the things found red, greps them, like grabing them out
                    if [[ $? -ne 0 ]]; then #If nothing matches
                        echo "No matching notes found." #Prints No matching found
                    fi
                else
                    echo "No notes found." #Echos no notes if their isn't anything in the file
                fi
            }

                # Main script logic
                case "$1" in #sets up a case
                    add)
                        if [[ -z "$2" ]]; then #if there isnt anything entered as a note,
                            echo "Error: Note text is required" >&2 # prints Note text is required
                            exit 1 #Exits
                        fi
                        add_note "$2" #calls our addnote and appends the input
                        ;;
                    list)
                        list_notes #calls our listnotes
                        ;;
                    search)
                        if [[ -z "$2" ]]; then #if search and nothing is entered
                            echo "Error: Search keyword is required" >&2 #echos Search keyword is required
                            exit 1 #exits
                        fi
                        search_notes "$2" #calls the searchnotes and uses the input
                        ;;
                    *)
                        echo "Usage: $0 {add|list|search} [text|keyword]" #echos the options of what you can do with our code.
                        exit 1 #exits
                        ;;
                esac #ends the case
