# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* Aditya Bhatia
* *email:* htxbhatia@ucdavis.edu

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect #### 
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


___

## Solution Assessment ##
Some general assessment:
As mentioned by the Student in their ReadMe, each camera does have the Draw_Camera_Logic field set to True in the editor but it stops working after camera 3. I also had an issue similar to this when working on my assignment and was not able to fix it in time either.

### Stage 1 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Camera is locked to position of player at all times. Works as intended.

___
### Stage 2 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
All fields correctly exported as required. Auto scroll works as expected. The player cannot move past the right, top, or bottom bounding boxes, and is constantly pushed by the left one. Note, this implementation has the player stay still instead of being matched to the scroll speed of the camera. Since, on Discord, the professor left it up to the student's choice as to how to implement it, I am not giving any penalties for that.

___
### Stage 3 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
All fields correctly exported as required. Camera moves ahead of player at follow_speed and goes upto leash distance and then matches player movement speed. There is jittering but this could have been fixed if the following logic was in _physics_process instead of regular _process. The minor flaw is that, the camera moves at both follow_speed and catchup_speed towards the player when the player has stopped moving. This makes it so that at high follow_speeds, the catchup_speed gets overpowered and makes no difference.

___
### Stage 4 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
All fields correctly exported as required. The camera moves ahead at lead speed up until leash distance and then it matches the player speed. When the player stops the camera catches up to the player at catchup speed. There are 2 minor errors with the implementation. First is that if the camera is leading in one direction, lets say, towards the right, and the player adds up input making it move diagonal, and then releases that up input, instead of the camera leading the player horizontally to the right, it stays being diagonal to the player. Second is that if the catchup delay is interrupted, i.e., the player is moved before the camera can start to catchup to it, then the catchup delay stops working unless the camera is allowed to re-center on the player.

___
### Stage 5 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
All fields correctly exported as required. Pushbox and speedup zones work correctly. Camera, as required, does not move when player is not in speedup zone.
___
# Code Style #


### Description ###
Check the scripts to see if the student code adheres to the GDScript style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.


#### Style Guide Infractions ####
* [Type Hints have redundant information](https://github.com/ensemble-ai/exercise-2-camera-control-Ambott967/blob/e2a9a4d798b3d2decda58db87e206d850d25e126/Obscura/scripts/camera_controllers/auto_scroll_camera.gd#L5) - Lines 5 - 7 have variables that are type hinted to be Vectors when they are explicitly assigned to new Vectors. This exact infraction is listed in the Godot Style Guide as a Bad Example.
* [More examples of redundant type hints](https://github.com/ensemble-ai/exercise-2-camera-control-Ambott967/blob/e2a9a4d798b3d2decda58db87e206d850d25e126/Obscura/scripts/camera_controllers/four_way_speed_up.gd#L6) - Lines 6 - 9 have redundant type information

* [Public variables declared after @onready directive](https://github.com/ensemble-ai/exercise-2-camera-control-Ambott967/blob/e2a9a4d798b3d2decda58db87e206d850d25e126/Obscura/scripts/camera_controllers/stage_4_camera.gd#L13) - Style guide says that public variables have to be declared before the @onready directive.


#### Style Guide Exemplars ####
Spacing between code blocks is well kept. The Student has done a great job in making sure that all code blocks have sufficient spacing between them and has made sure that functions have two lines of spacing between them.

___
#### Put style guide infractures ####

___

# Best Practices #

### Description ###

If the student has followed best practices then feel free to point at these code segments as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####
* [These variables could have been declared as private](https://github.com/ensemble-ai/exercise-2-camera-control-Ambott967/blob/e2a9a4d798b3d2decda58db87e206d850d25e126/Obscura/scripts/camera_controllers/stage_4_camera.gd#L13) - These variables are only used in this camera controller class and thus could have been made private.

#### Best Practices Exemplars ####
In this assignment, the amount of code required for each camera controller isn't that much and thus there aren't many chances to have best practice infractions. Overall the code is short and easy to read with no extremely long lines of code. Variable names are good and some helpful comments are present.