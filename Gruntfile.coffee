module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    bower:
      development:
        options:
          cleanTargetDir: true
          cleanBowerDir: true
          targetDir: './src/lib'

    clean:
      all:['build']

    coffee:
      development:
        options:
          bare: true
        files: [
          expand: true,
          src: '**/*.coffee',
          dest: 'build/js',
          cwd: 'src/script',
          ext: '.js'
        ]

    compass:
      development:
        options:
          sassDir: 'src/style/css'
          cssDir: 'build/css'

    jade:
      development:
        options:
          pretty: false
        files: [
          expand: true,
          src: '**/*.jade',
          dest: 'build/view',
          cwd: 'src/view/',
          ext: '.html'
        ,
          expand: true,
          src: ['!include/*.jade', '*.jade'],
          dest: 'build',
          cwd: 'src/',
          flatten: true,
          ext: '.html'
        ]

    watch:
      bower:
        files: 'bower.json'
        tasks: 'bower'
        options:
          livereload: true
      coffee:
        files: 'src/script/**/*.coffee'
        tasks: 'coffee:development'
        options:
          livereload: true
      compass:
        files: 'src/style/css/**/*.sass'
        tasks: 'compass:development'
        options:
          livereload: true
      jade:
        files: 'src/**/*.jade'
        tasks: 'jade:development'
        options:
          livereload: true

  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-compass"
  grunt.loadNpmTasks "grunt-contrib-jade"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-bower-task"

  # Default task(s).
  grunt.registerTask "default", ["bower:development", "clean:all", "coffee" ,"compass", "jade", "watch"]