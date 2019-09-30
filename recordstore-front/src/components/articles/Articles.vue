<template>
  <div class="max-w-md m-auto py-10">
    <div class="text-red" v-if="error">{{ error }}</div>
    <h3 class="font-mono font-regular text-3xl mb-4">Create a new article</h3>

    <form @submit.prevent="saveDraft">
      <div class="mb-6">
        <label for="article_title" class="label">Title</label>
        <input
          type="text"
          id="article_title"
          class="input"
          autofocus
          autocomplete="off"
          placeholder="Type a article name"
          v-model="newArticle.title">
      </div>

      <div class="mb-6">
        <label for="article_body" class="label">Body</label>
        <textarea
          type="text"
          id="article_body"
          class="input"
          autofocus
          autocomplete="off"
          placeholder="Type your article body here"
          v-model="newArticle.body">
        </textarea>
      </div>
    </form>

    <div class="flex-1 flex justify-between flex-wrap pr-4">
      <form @submit.prevent="saveDraft">
          <button class="bg-white hover:bg-gray-100 text-gray-800 font-semibold py-2 px-4 border border-gray-400 rounded shadow">
          Save draft
          </button>
      </form>

      <form @submit.prevent="addArticle">
          <button class="bg-indigo text-white hover:bg-gray-100 text-gray-800 font-semibold py-2 px-4 border border-gray-400 rounded shadow">
          Publish Article
          </button>
      </form>
    </div>

    <hr class="border border-grey-light my-6" />

    <ul class="list-reset mt-4">
      <li class="py-4" v-for="article in articles" :key="article.id" :article="article">
        <div class="flex items-center justify-between flex-wrap">
          <div class="flex-1 flex justify-between flex-wrap pr-4">
          <p class="block flex font-mono font-semibold flex items-center">
            <!-- <svg class="fill-current text-indigo w-6 h-6 mr-2" viewBox="0 0 24 24" width="24" height="24"><title>article vinyl</title><path d="M98,21.2 L78.8,21.2 L78.8,88.4070184 C78.8,93.6985281 83.0980664,98 88.4,98 C93.7030993,98 98,93.7050758 98,88.4070184" id="Layer-1" stroke="#222F3E" ></path></svg> -->
            <svg class="fill-current text-indigo w-6 h-6 mr-2" viewBox="0 0 100 100" width="24" height="24" xmlns="http://www.w3.org/2000/svg"><g fill="none" fill-rule="evenodd" stroke-linecap="round" stroke-linejoin="round" stroke="#222F3E" stroke-width="4">
            <path d="M78.8 21.2H98v67.207C98 93.699 93.702 98 88.4 98c-5.303 0-9.6-4.295-9.6-9.593"/>
            <path d="M89.843 98H11.597C6.307 98 2 93.702 2 88.4V2h76.8v86.407c0 5.298 4.29 9.593 9.606 9.593h1.437zM16 28h52.005M16 40h52.005M16 52h52.005M16 64h52.005M16 76h52.005M16 16h52.005"/></g></svg>
            {{ article.title }}
          </p>
          <p class="text-red-light" v-if="article.tag == 'draft'">{{ article.tag }}</p>
        </div>

        <button class="bg-transparent text-sm hover:bg-indigo hover:text-white text-indigo border border-indigo no-underline font-bold py-2 px-4 mr-2 rounded"
          @click.prevent="editArticle(article)">Edit</button>

        <button class="bg-transparent text-sm hover:bg-red text-red hover:text-white no-underline font-bold py-2 px-4 rounded border border-red"
         @click.prevent="removeArticle(article)">Delete</button>
        </div>

        <div v-if="article == editedArticle">
          <form action="" @submit.prevent="updateArticle(article)">
            <div class="mb-6 p-4 bg-white rounded border border-grey-light mt-4">

              <div class="mb-6">
                <label class="label">Title</label>
                <input class="input" v-model="article.title">
              </div>

              <div class="mb-6">
                <label class="label">Body</label>
                <input class="input" v-model="article.body">
              </div>

              <div class="mb-6">
                <label class="label">Tag</label>
                <!-- <input class="text" v-model="article.tag"> -->

                <div class="flex-1 flex justify-left flex-wrap pr-4">
                  <label class="switch">
                    <input type="checkbox"  v-model="article.tag" true-value="publish" false-value="draft">
                    <span class="slider round"></span>
                  </label>

                  <input type="text" v-model="article.tag" class="ml-2">
                </div>
              </div>

              <input type="submit" value="Update" class="bg-transparent text-sm hover:bg-blue hover:text-white text-blue border border-blue no-underline font-bold py-2 px-4 mr-2 rounded">

            </div>
          </form>
        </div>
      </li>
    </ul>
  </div>
</template>
<script src="../node_modules/@ckeditor/ckeditor5-build-classic/build/ckeditor.js"></script>
<script src="../node_modules/@ckeditor/ckeditor5-vue/dist/ckeditor.js"></script>
<script>
export default {
  name: 'Records',
  data () {
    return {
      articles: [],
      newArticle: [],
      error: '',
      editedArticle: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/articles')
        .then(response => { this.articles = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))

      this.$http.secured.get('/api/v1/articles')
        .then(response => { this.artists = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    use( CKEditor ){
    },
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    saveDraft () {
      const value = this.newArticle
      if (!value) {
        return
      }
      this.$http.secured.post('/api/v1/articles/', { article: { title: this.newArticle.title, body: this.newArticle.body, tag: 'draft' } })

        .then(response => {
          this.articles.push(response.data)
          this.newArticle = ''
        })
        .catch(error => this.setError(error, 'Cannot create draft article'))
    },
    addArticle () {
      const value = this.newArticle
      if (!value) {
        return
      }
      this.$http.secured.post('/api/v1/articles/', { article: { title: this.newArticle.title, body: this.newArticle.body, tag: 'publish' } })

        .then(response => {
          this.articles.push(response.data)
          this.newArticle = ''
        })
        .catch(error => this.setError(error, 'Cannot create article'))
    },
    removeArticle (article) {
      this.$http.secured.delete(`/api/v1/articles/${article.id}`)
        .then(response => {
          this.articles.splice(this.articles.indexOf(article), 1)
        })
        .catch(error => this.setError(error, 'Cannot delete article'))
    },
    editArticle (article) {
      this.editedArticle = article
    },
    updateArticle (article) {
      this.editedArticle = ''
      this.$http.secured.patch(`/api/v1/articles/${article.id}`, { article: { title: article.title, body: article.body, artist_id: article.artist } })
        .catch(error => this.setError(error, 'Cannot update article'))
    }
  }
}
</script>
<!-- eslint-disable -->

<style scoped>
  .switch {
  position: relative;
  display: inline-block;
  width: 60px;
  height: 34px;
}

.switch input { 
  opacity: 0;
  width: 0;
  height: 0;
}

.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 26px;
  width: 26px;
  left: 4px;
  bottom: 4px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: #2196F3;
}

input:focus + .slider {
  box-shadow: 0 0 1px #2196F3;
}

input:checked + .slider:before {
  -webkit-transform: translateX(26px);
  -ms-transform: translateX(26px);
  transform: translateX(26px);
}

/* Rounded sliders */
.slider.round {
  border-radius: 34px;
}

.slider.round:before {
  border-radius: 50%;
}
</style>>