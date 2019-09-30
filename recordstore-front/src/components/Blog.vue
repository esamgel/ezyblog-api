<template>
  <div class="bg-gray-200">
    <div class="container m-auto flex flex-wrap items-center justify-center">
<!--
      <div :style="{width: widthsize?'480px':'100%'}" class="max-w-lg rounded overflow-hidden shadow-lg mt-6 mr-6" v-for="(article, index) in articles" v-bind:key="article.id">
        <img class="w-full" v-bind:src="selectedImage[index]" alt="random images">
        <div class="px-6 py-4">
          <div class="font-bold text-xl mb-2">{{ article.title }}</div>
          <div class="flex items-center justify-between flex-wrap">
            <p class="text-grey-darker text-base" v-if="widthsize">
              {{ article.body.substring(0,90)+"......" }}
              <button class="bg-indigo-500 hover:bg-indigo-700 text-white font-bold py-1 px-2 rounded-full"
              @click.prevent="widthsize = !widthsize">read more</button>
            </p>
            <p class="text-grey-darker text-base" v-if="!widthsize">
              {{ article.body }}
              <button class="bg-indigo-500 hover:bg-indigo-700 text-white font-bold py-1 px-2 rounded-full"
              @click.prevent="widthsize = !widthsize">view less</button>
            </p>
          </div>
        </div>
        <div class="px-6 py-4">
          <span class="inline-block bg-gray-200 rounded-full px-3 py-1 text-sm font-semibold text-gray-700 mr-2">
            <p v-if="counts[index]!= '' && counts[index] > article.comments_count">{{counts[index]}} comments</p>
            <p v-else>{{article.comments_count}} comments</p>
          </span>
        </div>

        <div class="px-6 py-4">
          <button class="bg-transparent text-indigo-700 hover:bg-indigo-800 hover:text-white font-bold py-1 px-2 rounded-full"
            @click.prevent="commentShow=!commentShow">show comments</button>

        </div>

        <div class="-m-2 text-center">
          <div class="p-2">
            <div class="inline-flex items-center bg-white leading-none text-pink-600 rounded-full p-2 shadow text-teal text-sm">
              <span class="inline-flex bg-pink-600 text-white rounded-full h-6 px-3 justify-center items-center">Pink</span>
              <span class="inline-flex px-2">Donec sit amet neque risus. Pellentesque leo mauris, dictum et ligula in.</span>
            </div>
          </div>
        </div>
        <div class="px-6" v-show="commentShow" v-for="comment in comments" v-bind:key="comment.id">
          <p class="text-grey-darker text-base" v-show="comment.article_id == article.id && comment.article_id != ''">
            #{{comment.article_id}} {{ comment.name }} &mdash; {{ comment.text }}
          </p>
        </div>

        <div class="px-6 py-4" v-show="commentShow">
          <div v-bind:id="article.id" v-show="commentShow">
            <form @submit.prevent="submitComment()">
              <div class="mb-6 p-4 bg-white rounded border border-grey-light mt-4" v-show="commentShow">

                <div class="mb-6">
                  <label for="comment_name" class="label" v-show="commentShow">Your name</label>
                  <input
                    type="text"
                    id="comment_name"
                    class="input"
                    autofocus
                    autocomplete="off"
                    placeholder="Type your name"
                    v-model="newComment.name[index]"
                    v-show="commentShow">
                </div>

                <div class="mb-6">
                  <label for="comment_text" class="label" v-show="commentShow">Comment</label>
                  <textarea
                    type="text"
                    id="comment_text"
                    class="input"
                    autofocus
                    autocomplete="off"
                    placeholder="Type your comment here"
                    v-model="newComment.text[index]"
                    v-show="commentShow">
                  </textarea>
                </div>

                <input type="text" name="customfield" class="form-control" v-model="newComment.id[index]">

                <input type="submit" value="Leave a Comment" @click.prevent="submitComment(index, article.id, article.comments_count)"
                class="bg-transparent text-sm hover:bg-indigo-dark hover:text-white text-indigo no-underline font-bold py-2 px-4 rounded-full">
              </div>
            </form>
          </div>
        </div>

      </div> -->

      <div class="bg-white max-w-sm rounded overflow-hidden shadow-lg unded overflow-hidden shadow-lg mt-6 mr-6"
        :style="{width: widthsize?'480px':'100%'}"
        v-for="(article, index) in articles" v-bind:key="article.id">
        <img class="w-full" v-bind:src="selectedImage[index]" alt="random images">
        <div class="px-6 py-4">
          <div class="font-bold text-xl mb-2"><p class="text-gray-700 text-base">{{ article.title }}</p></div>
            <p class="text-gray-700 text-base" v-if="widthsize">
              {{ article.body.substring(0,110)+"......" }}
              <button class="bg-indigo-500 hover:bg-indigo-700 text-white border-none font-bold py-1 px-2 rounded-full"
              @click.prevent="widthsize = !widthsize">read more</button>
            </p>
            <p class="text-gray-700 text-base" v-if="!widthsize">
              {{ article.body }}
              <button class="bg-indigo-500 hover:bg-indigo-700 text-white border-none font-bold py-1 px-2 no-border rounded-full"
              @click.prevent="widthsize = !widthsize">view less</button>
            </p>
        </div>
        <div class="px-6 py-4">
          <span class="inline-block bg-gray-200 rounded-full px-3 py-1 text-sm font-semibold text-gray-700 mr-2">
            <div class="mt-0 mb-0" v-if="counts[index]!= '' && counts[index] > article.comments_count">{{counts[index]}} comments</div>
            <div class="py-0" v-else>{{article.comments_count}} comments</div>
          </span>
          <span class="inline-block bg-gray-200 rounded-full px-3 py-1 text-sm font-semibold text-gray-700 mr-2">#travel</span>
          <span class="inline-block bg-gray-200 rounded-full px-3 py-1 text-sm font-semibold text-gray-700">#winter</span>
        </div>

        <div class="px-6 py-4">
          <button class="bg-transparent text-indigo-700 hover:bg-indigo-800 border-none hover:text-white font-bold py-1 px-2 rounded-full"
            @click.prevent="commentShow = !commentShow">show comments</button>

        </div>

        <div class="bg-gray-400 max-w-sm rounded overflow-hidden unded overflow-hidden shadow-sm
         ml-0 mt-0 mr-0 mb-0">
          <div class="px-6 py-0" v-show="commentShow" v-for="comment in comments" v-bind:key="comment.id">
              <div class="p-2" v-show="comment.article_id == article.id && comment.article_id != ''">
                <div class="inline-flex items-center bg-white leading-none text-blue-600 rounded-full p-2 shadow text-teal text-sm">
                  <span class="inline-flex bg-blue-600 text-white rounded-full h-6 px-3 justify-center items-center"> {{ comment.name }}</span>
                  <span class="inline-flex px-2">{{ comment.text }}</span>
                </div>
            </div>
          </div>
        </div>

        <div class="px-6 py-0" v-show="commentShow">
          <form class="w-full max-w-sm" @submit.prevent="submitComment()">
            <div class="flex items-center border-b border-b-2 border-teal-500 py-2">
              <input id="comment_name" class="appearance-none bg-gray-100 border-none rounded w-sm text-gray-700 mr-3 py-1 px-2 leading-tight focus:outline-none"
              type="text" placeholder="Type comment here" aria-label="Comment" v-model="newComment.text[index]">
              <input id="comment_text" class="appearance-none bg-gray-100 border-none rounded w-full text-gray-700 mr-3 py-1 px-2 leading-tight focus:outline-none"
              type="text" placeholder="Name" aria-label="Comment" v-model="newComment.name[index]">
              <button @click.prevent="submitComment(index, article.id, article.comments_count)" class="flex-shrink-0 bg-indigo-500 hover:bg-indigo-700 border-indigo-500 hover:border-indigo-700 border-none text-sm border-4 text-white py-1 px-2 rounded" type="button">
                submit
              </button>
            </div>
          </form>
        </div>

      </div>

    </div>
  </div>
</template>

<script>

export default {
  name: 'Blog',
  data () {
    return {
      id: 0,
      commentShow: false,
      articles: [],
      error: '',
      widthsize: 'false',
      newComment: {
        id: [],
        name: [],
        text: [],
        show: []
      },
      comments: [],
      counts: [],
      size: 0,
      images: [
        'https://images.unsplash.com/photo-1541781774459-bb2af2f05b55?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1042&q=80',
        'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80',
        'https://images.unsplash.com/photo-1530789253388-582c481c54b0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80',
        'https://images.unsplash.com/photo-1498837167922-ddd27525d352?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80',
        'https://images.unsplash.com/photo-1503066211613-c17ebc9daef0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80',
        'https://images.unsplash.com/photo-1462899006636-339e08d1844e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80'
      ],
      selectedImage: []
    }
  },
  created () {
    // var self = this

    this.$http.secured.get('/')
      .then(response => { this.articles = response.data })
      .catch(error => this.setError(error, 'Something went wrong'))

    this.$http.secured.get('/api/v1/articles/:article_id/comments')
      .then(response => { this.comments = response.data })
      .catch(error => this.setError(error, 'Something went wrong'))

    this.$http.secured.get('/api/v1/articles/:article_id/counts')
      .then(response => {
        this.size = response.data
        this.randomisPic()
        // for (var i = 0; i < this.size; i++) {
        //   self.commentShow.push(false)
        // }
      })
      .catch(error => this.setError(error, 'Something went wrong'))
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },

    submitComment (index, articleId, count) {
      const value = this.newComment
      if (!value) {
        return
      }
      this.$http.secured.post('/api/v1/articles/:article_id/comments', { comment: { name: this.newComment.name[index], text: this.newComment.name[index], article_id: articleId } })

        .then(response => {
          this.comments.push(response.data)
          this.newComment.name[index] = ''
          this.newComment.text[index] = ''
          this.counts[index] = count + 1
        })
        .catch(error => this.setError(error, 'Cannot save comment'))
    },
    randomisPic () {
      // randomised picture selectedImage from images
      for (var i = 0; i < this.size; i++) {
        console.log(i)
        var idx = Math.floor(Math.random() * this.images.length)
        this.selectedImage.push(this.images[idx])
      }
    }
  }
  // computed: {
  //   toggleComment (index, value) {
  //     this.commentShow[index] = !value

  //     return self.commentShow[index]
  //   }
  // }
}
</script>

<!-- eslint-disable -->