$(function() {
  $olderStories = $('#olderStories');

  $olderStories.on('click', function(){
    jQuery.ajax({
      url: 'http://np-ec2-nytimes-com.s3.amazonaws.com/dev/test/nyregion.js',
      contentType: "application/json; charset=utf-8",
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
      var otherStoriesDiv = $("<div/>", { class: 'row' });
      otherStoriesDiv.append(NYTD.generateDiv(story[0]))
      otherStoriesDiv.append(NYTD.generateDiv(story[1]))

      NYTD.appendStory(otherStoriesDiv);
    })
  },

  storyParams: function(story) {
    return {
      url: story.url,
      byline: story.byline,
      headline: unescapeHTML(NYTD.toggleableText(story.headline)),
      lastPublished: NYTD.formattedDate(story.lastPublished),
      image: NYTD.storyImage(story.images[0]),
      summary: NYTD.toggleableText(story.summary)
    }
  },

  formattedDate: function(dateString) {
    var splitDate = dateString.split('.');
    var date = new Date(splitDate[0]);
    var month = date.getMonth();
    var day = date.getDate();
    var year = date.getFullYear();

    return(month + '/' + day + '/' + year);
  },

  storyImage: function(images) {
    if (images !== undefined) {
      return '//graphics8.nytimes.com/' + images.types[0].content;
    }
  },

  generateDiv: function(story) {
    var div = $("<div/>", { class: 'col-6 col-m-6' });
    var innerDiv = _.template("<p class='headline'><a href=<%- url %>><%- headline %></a></p><p class='byline'><%- byline %></p><p class='last-published'><%- lastPublished %></p><div class='row story-info'><div class='col-5'><img src=<%- image %>></img></div><div class='col-7'><p class='summary'><%- summary %></p></div></div>");
    var article = innerDiv(NYTD.storyParams(story));

    div.append(article);
    return div
  },

  displaySideStories: function(stories) {
    _.each(stories, function(story){
      var div = $("<div/>");
      var innerDiv = _.template("<ul><li class='headline'><a href=<%- url %>><%- headline %></a></li><li class='byline'><%- byline %></li><li class='last-published'><%- lastPublished %></li><li class='row story-info'></li><li class='side-summary'><%- summary %></li>");

      var article = innerDiv(NYTD.storyParams(story))
      div.append(article);

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

var escapeChars = { lt: '<', gt: '>', quot: '"', apos: "'", amp: '&' };

function unescapeHTML(str) {//modified from underscore.string and string.js
  return str.replace(/\&([^;]+);/g, function(entity, entityCode) {
    var match;

    if ( entityCode in escapeChars) {
        return escapeChars[entityCode];
    } else if ( match = entityCode.match(/^#x([\da-fA-F]+)$/)) {
        return String.fromCharCode(parseInt(match[1], 16));
    } else if ( match = entityCode.match(/^#(\d+)$/)) {
        return String.fromCharCode(~~match[1]);
    } else {
        return entity;
    }
  });
}
