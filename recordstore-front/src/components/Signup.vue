<template>
  <!-- <div class="max-w-sm m-auto my-8">
    <div class="border p-10 border-grey-light shadow rounded">
      <h3 class="text-2xl mb-6 text-grey-darkest">Sign Up</h3>
      <form @submit.prevent="signup">
        <div class="text-red" v-if="error">{{ error }}</div>

        <div class="mb-6">
          <label for="email" class="label">E-mail Address</label>
          <input type="email" v-model="email" class="input" id="email" placeholder="andy@web-crunch.com">
        </div>

        <div class="mb-6">
          <label for="password" class="label">Password</label>
          <input type="password" v-model="password" class="input" id="password" placeholder="Password">
        </div>

        <div class="mb-6">
          <label for="password_confirmation" class="label">Password Confirmation</label>
          <input type="password" v-model="password_confirmation" class="input" id="password_confirmation" placeholder="Password Confirmation">
        </div>
        <button type="submit" class="font-sans font-bold px-4 rounded cursor-pointer no-underline bg-indigo hover:bg-indigo-dark block w-full py-4 text-white items-center justify-center">Sign Up</button>

        <div class="my-4"><router-link to="/signin" class="link-grey">Sign In</router-link></div>
      </form>
    </div>
  </div> -->

  <div class="bg-gray-200">
    <div class="w-full max-w-xs m-auto my-0 py-8">
      <form class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-1" @submit.prevent="signup">
        <div class="mb-6">
          <label class="block text-gray-700 text-sm font-bold mb-2" for="email">
            Email
          </label>
          <input v-model="email" class="shadow appearance-none border rounded py-2 px-3 w-5/6 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="username" type="text" placeholder="Email">
        </div>
        <div class="mb-6">
          <label class="block text-gray-700 text-sm font-bold mb-2" for="password">
            Password
          </label>
          <input v-model="password" class="shadow appearance-none border border-red-500 rounded w-5/6 py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline" id="password" type="password" placeholder="******************">
          <!-- <p class="text-red-500 text-xs italic">Please enter a password.</p> -->
        </div>
        <div class="mb-6">
          <label class="block text-gray-700 text-sm font-bold mb-2" for="password">
            Confirm Password
          </label>
          <input v-model="password_confirmation" class="shadow appearance-none border border-red-500 rounded w-5/6 py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline" id="password" type="password" placeholder="******************">
          <!-- <p class="text-red-500 text-xs italic">Please confirm a password.</p> -->
        </div>
        <div class="flex items-center justify-between">
          <button class="bg-indigo-500 hover:bg-indigo-700 text-white border-none font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline" type="submit">
            Sign Up
          </button>
          <!-- <a class="inline-block no-underline align-baseline font-bold text-sm text-indigo-500 hover:text-blue-800" href="#"> -->
          <div class="inline-block no-underline align-baseline font-bold text-sm text-indigo-500 hover:text-blue-800"><router-link to="/signin" class="link-grey">Sign In</router-link></div>
          <!-- </a> -->
        </div>
      </form>
    </div>
    <p class="text-center text-gray-500 text-xs mt-0 py-0">
      &copy;2019 Acme Corp. All rights reserved.
    </p>
  </div>
</template>

<script>
export default {
  name: 'Signup',
  data () {
    return {
      email: '',
      password: '',
      password_confirmation: '',
      error: ''
    }
  },
  created () {
    this.checkedSignedIn()
  },
  updated () {
    this.checkedSignedIn()
  },
  methods: {
    signup () {
      this.$http.plain.post('/signup', { email: this.email, password: this.password, password_confirmation: this.password_confirmation })
        .then(response => this.signupSuccessful(response))
        .catch(error => this.signupFailed(error))
    },
    signupSuccessful (response) {
      if (!response.data.csrf) {
        this.signupFailed(response)
        return
      }

      localStorage.csrf = response.data.csrf
      localStorage.signedIn = true
      this.error = ''
      this.$router.replace('/records')
    },
    signupFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || 'Something went wrong'
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkedSignedIn () {
      if (localStorage.signedIn) {
        this.$router.replace('/records')
      }
    }
  }
}
</script>
