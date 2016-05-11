$(function() {
  $olderStories = $('#olderStories');

  $olderStories.on('click', function(){
    jQuery.ajax({
      url: 'http://np-ec2-nytimes-com.s3.amazonaws.com/dev/test/nyregion.js',
      contentType: 'application/javascript',
      dataType: "jsonp",
      type: "GET",
   });
  });
});

NYTD = {
  render_section_front: function(data) {
    var stories = NYTD.displayOlderStories(data)
  },

  displayOlderStories: function(data) {
    var stories = NYTD.getStories(data)
    var groupedStories = _.groupBy(stories, function(story){
      return story.images.length > 0
    })

    var storiesWithImages = groupedStories.true
    var storiesWithoutImages = groupedStories.false
    NYTD.displayFullStories(storiesWithImages)
    NYTD.displaySideStories(storiesWithoutImages)

    $olderStories.remove();
  },

  groupedStories: function(stories)  {
    return _.chain(stories).groupBy(function(story, index){
        return Math.floor(index/2);
      }).toArray().value();
  },

  appendStory: function(div) {
    $('.full-stories').last().append(div);
  },

  displayFullStories: function(stories) {
    var firstStoryDiv = NYTD.generateDiv(stories.shift())
    NYTD.appendStory(firstStoryDiv);

    _.each(NYTD.groupedStories(stories), function(story, index){
      var otherStoriesDiv = document.createElement('div');
      otherStoriesDiv.className = 'row'
      otherStoriesDiv.appendChild(NYTD.generateDiv(story[0]))
      otherStoriesDiv.appendChild(NYTD.generateDiv(story[1]))

      NYTD.appendStory(otherStoriesDiv);
    })
  },

  storyParams: function(story) {
    return {
      url: story.url,
      byline: story.byline,
      headline: NYTD.toggleableText(story.headline),
      lastPublished: story.lastPublished,
      image: NYTD.storyImage(story.images[0]),
      summary: NYTD.toggleableText(story.summary)
    }
  },

  storyImage: function(images) {
    if (images !== undefined) {
      return '//graphics8.nytimes.com/' + images.types[0].content;
    }
  },

  generateDiv: function(story) {
    var div = document.createElement('div');
    div.className = 'col-6 col-m-6';
    var innerDiv = _.template("<p class='headline'><a href=<%- url %>><%- headline %></a></p><p class='byline'><%- byline %></p><p class='last-published'><%- lastPublished %></p><div class='row story-info'><div class='col-5'><img src=<%- image %>></img></div><div class='col-7'><p class='summary'><%- summary %></p></div></div>");
    var article = innerDiv(NYTD.storyParams(story));
    div.innerHTML = article;
    return div
  },

  displaySideStories: function(stories) {
    _.each(stories, function(story){
      var div = document.createElement('div');
      var innerDiv = _.template("<ul><li class='headline'><a href=<%- url %>><%- headline %></a></li><li class='byline'><%- byline %></li><li class='lastPublished'><%- lastPublished %></li><li class='row story-info'></li><li class='side-summary'><%- summary %></li>");
      var article = innerDiv(NYTD.storyParams(story))
      div.innerHTML = article;

      $('.stories-without-images').last().append(div);
    })
  },

  getStories: function(data) {
    var collectionsArray = _.pluck(data.page.content, 'collections')
    var collections = _.flatten(collectionsArray)
    var collectionAssets = _.filter(collections, function(collection) {
      return collection.assets.length > 0
    })
    var assetsArray = _.pluck(collectionAssets, 'assets')
    var assets = _.flatten(assetsArray)
    var stories = _.filter(assets, function(asset){
      return asset.type === 'Article'
    })
    return stories
  },

  martian: function() {
    return NYTD.languageParam() === 'Martian'
  },

  toggleableText: function(text) {
    if(NYTD.martian()){
      return NYTD.martianize(text)
    } else {
      return text
    }
  },

  martianize: function(text) {
    var martianString = text.replace(/[\w']{4,}/g, function(word){
      if (word.charAt(0) === word.charAt(0).toUpperCase()) {
        return 'Boinga'
      } else {
        return 'boinga'
      }
    });
    return martianString;
  },

  languageParam: function() {
    url = window.location.href;
    var regex = new RegExp("[?&]language(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (results == null) {
      ''
    } else {
      return decodeURIComponent(results[2].replace(/\+/g, " "));
    }
  }
}
