// @author Gianluigi Mango
module.exports = function(grunt) {
	require("load-grunt-tasks")(grunt)

	grunt.initConfig({
		coffee: {
		  glob_to_multiple: {
		    expand: true,
		    flatten: false,
		    cwd: 'dev/',
		    src: ['**/**/*.coffee'],
		    dest: 'dist/',
		    ext: '.js'
		  }
		},

		watch: {
			scripts: {
				files: 'dev/**/**/*.coffee',
				tasks: ['coffee'],
				options: {
                    spawn: false
                }
			}
		}
	})

	grunt.loadNpmTasks('grunt-contrib-watch')
	grunt.loadNpmTasks('grunt-contrib-coffee')

	grunt.registerTask('default', ['watch'])
}