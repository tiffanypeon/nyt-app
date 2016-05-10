NYTD = {
  render_section_front: function(data) {
    var stories = filterOutStories(data)
  }
}

$(function() {
  $("#olderStories").click( function(){
    jQuery.ajax({
      url: 'http://np-ec2-nytimes-com.s3.amazonaws.com/dev/test/nyregion.js',
      contentType: 'application/javascript',
      dataType: "jsonp",
      type: "GET",
   });
  });
});

function groupedStories(stories) {
  return _.chain(stories).groupBy(function(story, index){
      return Math.floor(index/2);
    }).toArray().value();
}

function appendStory(div) {
  $('.full-stories').last().append(div);
}

function displayFullStories(stories) {
  var firstStoryDiv = generateDiv(stories.shift())
  appendStory(firstStoryDiv);

  _.each(groupedStories(stories), function(story, index){
    var otherStoriesDiv = document.createElement('div');
    otherStoriesDiv.className = 'row'
    otherStoriesDiv.appendChild(generateDiv(story[0]))
    otherStoriesDiv.appendChild(generateDiv(story[1]))

    appendStory(otherStoriesDiv);
  })
}

function storyParams(story) {
  return {
    url: story.url,
    byline: story.byline,
    headline: toggleableText(story.headline),
    last_published: story.lastPublished,
    image: storyImage(story.images[0]),
    summary: toggleableText(story.summary)
  }
}

function storyImage(images) {
  debugger
  if (images !== undefined) {
    return 'https://graphics8.nytimes.com/' + images.types[0].content;
  }
}

function generateDiv(story) {
  var div = document.createElement('div');
  div.className = 'col-6 col-m-6';
  var inner_div = _.template("<p class='headline'><a href=<%- url %>><%- headline %></a></p><p class='byline'><%- byline %></p><p class='last-published'><%- last_published %></p><div class='row story-info'><div class='col-5'><img src=<%- image %>></img></div><div class='col-7'><p class='summary'><%- summary %></p></div></div>");
  var article = inner_div(storyParams(story));
  div.innerHTML = article;
  return div
}

function displaySideStories(stories) {
  _.each(stories, function(story){
    var div = document.createElement('div');
    var inner_div = _.template("<ul><li class='headline'><a href=<%- url %>><%- headline %></a></li><li class='byline'><%- byline %></li><li class='last-published'><%- last_published %></li><li class='row story-info'></li><li class='side-summary'><%- summary %></li>");
    var article = inner_div(storyParams(story))
    div.innerHTML = article;

    $('.stories-without-images').last().append(div);
  })
}

function getStories(data){
  var collectionsArray = _.pluck(data.page.content, 'collections')
  var collections = _.flatten(collectionsArray)
  var collectionAssets = _.filter(collections, function(collection) {
    return collection.assets.length > 0
  })
  var assets_array = _.pluck(collectionAssets, 'assets')
  var assets = _.flatten(assets_array)
  var stories = _.filter(assets, function(asset){
    return asset.type === 'Article'
  })
  return stories
}

function filterOutStories(data) {
  var stories = getStories(data)
  var groupedStories = _.groupBy(stories, function(story){
    return story.images.length > 0
  })

  var storiesWithImages = groupedStories.true
  var storiesWithoutImages = groupedStories.false
  displayFullStories(storiesWithImages)
  displaySideStories(storiesWithoutImages)

  $('#olderStories').remove();
}

function martian() {
  return languageParam() === 'Martian'
}

function toggleableText(text) {
  if(martian()){
    return martianize(text)
  } else {
    return text
  }
}

function martianize(text) {
  var martianString = text.replace(/[\w']{4,}/g, function(word){
    if (word.charAt(0) === word.charAt(0).toUpperCase()) {
      return 'Boinga'
    } else {
      return 'boinga'
    }
  });
  return martianString;
}

function languageParam() {
  url = window.location.href;
  var regex = new RegExp("[?&]language(=([^&#]*)|&|#|$)"),
      results = regex.exec(url);
  if (results == null) {
    ''
  } else {
    return decodeURIComponent(results[2].replace(/\+/g, " "));
  }
}

