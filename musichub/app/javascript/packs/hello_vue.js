/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

import Vue from 'vue/dist/vue.esm'
import VueResource from 'vue-resource'

Vue.use(VueResource)

document.addEventListener('turbolinks:load', () => {
  Vue.http.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')

    var element = document.getElementById("team-form")
    if (element != null) {

      var id = element.dataset.id
      var team = JSON.parse(element.dataset.team)
      var users_attributes = JSON.parse(element.dataset.usersAttributes)
      users_attributes.forEach(function(user) { user._destroy = null })
      team.users_attributes = users_attributes

      var app = new Vue({
        el: element,
        data: function() {
          return {
            id: id,
            team: team,
            errors: [],
            scrollPosition: null
          }
        },
        mounted() {
          window.addEventListener('scroll', this.updateScroll);
        },
        methods: {
          updateScroll() {
            this.scrollPosition = window.scrollY
          },
          addUser: function() {
            this.team.users_attributes.push({
              id: null,
              name: "",
              email: "",
              //position: "",
              _destroy: null
            })
          },


          removeUser: function(index) {
            var user = this.team.users_attributes[index]

            if (user.id == null) {
              this.team.users_attributes.splice(index, 1)
            } else {
              this.team.users_attributes[index]._destroy = "1"
            }
          },

          undoRemove: function(index) {
            this.team.users_attributes[index]._destroy = null
          },

          saveTeam: function() {
            // Create a new team

            if (this.id == null) {
              this.$http.post('/teams', { team: this.team }).then(response => {
                Turbolinks.visit(`/teams/${response.body.id}`)
              }, response => {
                console.log(response)

                if (response.status = 422) {
                  var json = JSON.parse(response.bodyText);
                  this.errors = json["users.email"][0];
                }
              })


            // Edit an existing team
            } else {
              this.$http.put(`/teams/${this.id}`, { team: this.team }).then(response => {
                Turbolinks.visit(`/teams/${response.body.id}`)
              }, response => {
                console.log(response)
              })
            }
          },

          existingTeam: function() {
            return this.team.id != null
          }
        }
      })

    }
  })


// The above code uses Vue without the compiler, which means you cannot
// use Vue to target elements in your existing html templates. You would
// need to always use single file components.
// To be able to target elements in your existing html/erb templates,
// comment out the above code and uncomment the below
// Add <%= javascript_pack_tag 'hello_vue' %> to your layout
// Then add this markup to your html template:
//
// <div id='hello'>
//   {{message}}
//   <app></app>
// </div>


// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// document.addEventListener('DOMContentLoaded', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: {
//       message: "Can you say hello?"
//     },
//     components: { App }
//   })
// })
//
//
//
// If the using turbolinks, install 'vue-turbolinks':
//
// yarn add 'vue-turbolinks'
//
// Then uncomment the code block below:
//
// import TurbolinksAdapter from 'vue-turbolinks'
// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// Vue.use(TurbolinksAdapter)
//
// document.addEventListener('turbolinks:load', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: {
//       message: "Can you say hello?"
//     },
//     components: { App }
//   })
// })
