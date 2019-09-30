<template>
  <header class="flex items-center justify-between flex-wrap bg-indigo-600 p-6">
    <div class="flex items-center flex-shrink-0 text-white mr-6">
        <svg class="fill-current h-8 w-8 mr-2" viewBox="0 0 24 24" width="24" height="24"><title>Blog</title><path d="M18 9.87V20H2V9.87a4.25 4.25 0 0 0 3-.38V14h10V9.5a4.26 4.26 0 0 0 3 .37zM3 0h4l-.67 6.03A3.43 3.43 0 0 1 3 9C1.34 9 .42 7.73.95 6.15L3 0zm5 0h4l.7 6.3c.17 1.5-.91 2.7-2.42 2.7h-.56A2.38 2.38 0 0 1 7.3 6.3L8 0zm5 0h4l2.05 6.15C19.58 7.73 18.65 9 17 9a3.42 3.42 0 0 1-3.33-2.97L13 0z"></path></svg>
        <a href="/" class="uppercase text-sm font-mono pl-4 font-semibold no-underline text-white hover:text-indigo-darker">EZBlog</a>
    </div>
    <div class="block lg:hidden">
      <button class="flex items-center px-3 py-2 border rounded text-indigo-200 border-indigo-400 hover:text-white hover:border-white">
        <svg class="fill-indigo-300 h-3 w-3" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><title>Menu</title><path d="M0 3h20v2H0V3zm0 6h20v2H0V9zm0 6h20v2H0v-2z"/></svg>
      </button>
    </div>
    <div class="w-full block flex-grow lg:flex lg:items-center lg:w-auto">
      <div class="text-sm lg:flex-grow">
        <router-link to="/blog" class="block mt-4 lg:inline-block lg:mt-0 text-indigo-200 no-underline hover:text-white mr-4">Blog</router-link>
        <router-link to="/signin" class="block mt-4 lg:inline-block lg:mt-0 text-indigo-200 no-underline hover:text-white mr-4" v-if="!signedIn()">Sign in</router-link>
        <router-link to="/signup" class="block mt-4 lg:inline-block lg:mt-0 text-indigo-200 no-underline hover:text-white mr-4" v-if="!signedIn()">Sign Up</router-link>
        <router-link to="/articles" class="block mt-4 lg:inline-block lg:mt-0 text-indigo-200 no-underline hover:text-white mr-4" v-if="signedIn()">My Articles</router-link>
        <a href="#" @click.prevent="signOut" class="link-grey px-2 no-underline" v-if="signedIn()">Sign out</a>
      </div>
      <div>
        <!-- <a href="#" class="inline-block text-sm px-4 py-2 leading-none border rounded text-white border-white hover:border-transparent hover:text-teal-500 hover:bg-white mt-4 lg:mt-0">Download</a> -->
      </div>
    </div>
  </header>
</template>

<script>
export default {
  name: 'Header',
  created () {
    this.signedIn()
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    signedIn () {
      return localStorage.signedIn
    },
    signOut () {
      this.$http.secured.delete('/signin')
        .then(response => {
          delete localStorage.csrf
          delete localStorage.signedIn
          this.$router.replace('/')
        })
        .catch(error => this.setError(error, 'Cannot sign out'))
    }
  }
}
</script>
