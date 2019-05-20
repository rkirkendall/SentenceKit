# SentenceKit

SentenceKit is an iOS framework for building user interfaces with natural language. This type of UI has been used successfully by apps like Beats by Dre (pre Apple Music) and Philz Coffee; both of which served as inspirations for this project. Natural language interfaces enjoy the advantage of feeling instantly familiar to users. If you can read, you already know how to use it. NLI's can also help to provide structure to the UX, as sentences are inherently narrative. They're fun to develop with, too, because you have to step into the user's story in order to compose the sentences about what they're doing inside of your application. 

The goal in designing the SentenceKit API was to remove as much overhead as possible from the process of turning those user stories in to a functional UI while still allowing for customization and extension.

## Example
![Example screenshot](https://i.imgur.com/5836LkK.png)

```Swift

// Define controls
let sizeChoice = MultiChoice(tag: "size")
let creamAmtChoice = MultiChoice("creamAmt")
let creamTypeChoice = MultiChoice("creamType")
let sweetnerAmtChoice = MultiChoice("sweetnerAmt")
let sweetnerTypeChoice = MultiChoice("sweetnerType")
let temperatureChoice = MultiChoice("temp")
let addlNotes = FreeEntry("addlNotes")
var controls: [ControlFragment] = [sizeChoice,
                creamAmtChoice,
                creamTypeChoice,
                sweetnerAmtChoice,
                sweetnerTypeChoice,
                temperatureChoice,
                addlNotes]


...

// Configure controls

sizeChoice.options = ["Large", "Small"]
creamAmtChoice.options = ["Creamy", "Medium", "Light", "None"]
creamTypeChoice.options = ["Cream", "Whole Milk", "2% Milk", "Low-Fat Milk",
                            "Non-Fat Milk", "Almond Milk", "Soy Milk", "Vanilla Soy"]
sweetnerAmtChoice.options = ["Sweet", "Medium", "Light", "None"]
sweetnerTypeChoice.options = ["Sugar", "Honey", "Splenda", "Stevia", "Sweet'N Low", "Equal"]
temperatureChoice.options = ["Hot", "Iced"]

// Build sentence by concatenating fragments

sentence += "I'll have a "
sentence += sizeChoice
sentence += ", with "
sentence += creamAmtChoice
sentence += " "
sentence += creamTypeChoice
sentence += "\nand\n"
sentence += sweetnerAmtChoice
sentence += " "
sentence += sweetnerTypeChoice
sentence += ", "
sentence += temperatureChoice
sentence += ".\n\n"
sentence += addlNotes

// Add resolutions to ensure the sentence always presents user selections in a sensible manner

sentence.resolutions += { if self.sweetnerAmtChoice.alias == "None" { self.sweetnerAmtChoice.alias = "No"; self.sweetnerTypeChoice.alias = "Sugar" }}
sentence.resolutions += { if self.sweetnerAmtChoice.alias == "Sweet" { self.sweetnerAmtChoice.alias = "lots of" }}
sentence.resolutions += { if self.creamAmtChoice.alias == "None" { self.creamAmtChoice.alias = "No"; self.creamTypeChoice.alias = "Cream" }}
sentence.resolutions += { if self.creamAmtChoice.alias == "Creamy" { self.creamAmtChoice.alias = "lots of" }}
sentence.resolutions += { for c in self.controls { c.alias = c.alias?.lowercased() } }

// Define a style to customize the appearance of your sentence UI, or use one of the presets

let style = Style.MintMojito        
sentenceView.style = style
view.backgroundColor = style.backgroundColor

// Present the sentence in a SentenceView
let sentenceView = SentenceView(autolayout: true)
sentenceView.sentence = sentence

```
