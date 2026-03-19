# dormcare

A new Flutter project.

# How to use git

- to commit and push your code to github
    git add .
    git commit -m "your commit message"
    git push (for the first time, you need to use git push -u origin <your-branch-name>, then you can just use git push for the next time)

- to merge branch main to your branch
    git checkout <your-branch-name>
    git pull origin main

- to merge your branch to main ------or------ do it on github website(like I taught you guys)
    git checkout main
    git pull origin main
    git merge <your-branch-name>
    git push origin main

- to pull the latest code from main to your branch(delete your branch then create a new branch with the same name)
    git checkout main
    git pull origin main
    git branch -D <your-branch-name>
    git checkout -b <your-branch-name>
or do it on github website, just delete your branch then create a new branch with the same name, It's might be easier to understand for you guys