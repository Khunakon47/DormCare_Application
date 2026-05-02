# dormcare

A new Flutter project.

# How to use git

- to commit and push your code to github
  git add .
  git commit -m "your commit message"
  git push (for the first time, you need to use 'git push -u origin <your-branch-name>', then you can just use 'git push' for the next time)

- to merge your branch to main ------or------ do it on github website(like I taught you guys)
  git checkout main
  git pull origin main
  git merge <your-branch-name>
  git push origin main

- to merge main to your branch
  git checkout <your-branch-name>
  git pull origin main

- to pull the latest code from main to your branch(delete your branch then create a new branch with the same name)
  git checkout main
  git pull origin main
  git branch -D <your-branch-name>
  git checkout -b <your-branch-name>
  or do it on github website, just delete your branch then create a new branch with the same name, It's might be easier to understand for you guys

# Project structure

A high-level overview of this Flutter project layout:

```
.
├── android/                # Android-specific Gradle project and native code
├── ios/                    # iOS-specific Xcode project and native code
├── linux/                  # Linux build artifacts and native shell
├── macos/                  # macOS build artifacts and native shell
├── windows/                # Windows build artifacts and native shell
├── web/                    # Web build output and web-specific assets
├── assets/                 # Shared assets (images, fonts, etc.)
├── lib/                    # Main Dart source code for the app
│   ├── main_owner.dart      # Entry point for owner app mode
│   ├── main_tenant.dart     # Entry point for tenant app mode
│   ├── component/          # Reusable UI components
│   │   ├── owner/
│   │   └── tenant/
│   ├── model/              # Data models and serializable classes
│   └── screen/             # App screens and page UI
│      ├── owner/
│      │    └── main_owner_screen.dart   # Main owner navigation shell (bottom nav)
│      └── tenant/
│           └── main_tenant_screen.dart  # Main tenant navigation shell (bottom nav)
├── test/                   # Unit and widget tests
├── pubspec.yaml            # Dart/Flutter dependencies and metadata
├── analysis_options.yaml   # Static analysis and linting rules
└── README.md               # Project documentation (this file)
```

test