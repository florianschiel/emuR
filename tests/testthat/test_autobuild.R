##' testthat tests for autobuild
##'
##' @author Raphael Winkelmann
context("testing autobuild functions")

path2ae = system.file("extdata/emu/DBs/ae/", package = "emuR")

ae = load.emuDB(path2ae, verbose = F)

##############################
test_that("bad calls to autobuild.linkFromTimes", {
  
  expect_error(autobuild.linkFromTimes(ae, 'Phoneti', 'Tone'))
  expect_error(autobuild.linkFromTimes(ae, 'Phonetic', 'Ton'))
  expect_error(autobuild.linkFromTimes(ae, 'Phonetic', 'Tone'))
  
})


##############################
test_that("correct links are present after autobuild.linkFromTimes with EVENTS", {
  # add linkDef.
  tmpLinkDef = create.schema.linkDefinition(type='ONE_TO_MANY', superlevelName='Phonetic', sublevelName='Tone')
  ae$DBconfig$linkDefinitions[[length(ae$DBconfig$linkDefinitions) + 1]] = tmpLinkDef 
  
  res = autobuild.linkFromTimes(ae, 'Phonetic', 'Tone', FALSE)
  
  expect_equal(dim(res$links)[1], 839)
  expect_equal(res$links[786,]$session, '0000')
  expect_equal(res$links[786,]$bundle, 'msajc003')
  expect_equal(res$links[786,]$fromID, 149)
  expect_equal(res$links[786,]$toID, 181)

  expect_equal(res$links[787,]$session, '0000')
  expect_equal(res$links[787,]$bundle, 'msajc003')
  expect_equal(res$links[787,]$fromID, 156)
  expect_equal(res$links[787,]$toID, 182)
})

#############################
test_that("no duplicates are present after autobuild.linkFromTimes with EVENTs", {
  # add linkDef.
  tmpLinkDef = create.schema.linkDefinition(type='ONE_TO_MANY', superlevelName='Phonetic', sublevelName='Tone')
  ae$DBconfig$linkDefinitions[[length(ae$DBconfig$linkDefinitions) + 1]] = tmpLinkDef
  
  # addlink that will also be automatically linked
  ae$links[786,] = c('0000', 'msajc003', 149, 181, NA)
  res = autobuild.linkFromTimes(ae, 'Phonetic', 'Tone', FALSE)
  
  # extract only one link to be present
  expect_equal(sum(res$links$fromID == 149 & res$links$toID == 181), 1)
  
  # if re-run nothing should change (duplicate links)
  res2 = autobuild.linkFromTimes(ae, 'Phonetic', 'Tone', FALSE)
  expect_equal(dim(res$links)[1], dim(res2$links)[1])

})


##############################
test_that("correct links are present after autobuild.linkFromTimes with SEGMENTS linkDef type ONE_TO_MANY", {
  # add linkDef.
  tmpLinkDef = create.schema.linkDefinition(type='ONE_TO_MANY', superlevelName='Phonetic', sublevelName='Phonetic2')
  ae$DBconfig$linkDefinitions[[length(ae$DBconfig$linkDefinitions) + 1]] = tmpLinkDef

  # add levelDef.
  tmpLevelDef = create.schema.levelDefinition(name = 'Phonetic2', type = 'SEGMENT', attributeDefinitions = list())
  ae$DBconfig$levelDefinitions[[length(ae$DBconfig$levelDefinitions) + 1]] = tmpLevelDef
  
  # add item to Phonetic2 = left edge
  ae$items[737, ] = c('ae_0000_msajc003_999', '0000', 'msajc003', 'Phonetic2', 999, 'SEGMENT', 1, 20000, NA, 3749, 10, 'testLabel12')
  res = autobuild.linkFromTimes(ae, 'Phonetic', 'Phonetic2', FALSE)
  expect_equal(res$links[786,]$fromID, 147)
  expect_equal(res$links[786,]$toID, 999)
  
  # add item to Phonetic2 = exact match
  ae$items[737, ] = c('ae_0000_msajc003_999', '0000', 'msajc003', 'Phonetic2', 999, 'SEGMENT', 1, 20000, NA, 3749, 1389, 'testLabel12')
  res = autobuild.linkFromTimes(ae, 'Phonetic', 'Phonetic2', FALSE)
  expect_equal(res$links[786,]$fromID, 147)
  expect_equal(res$links[786,]$toID, 999)
  
  # add item to Phonetic2 = completely within
  ae$items[737, ] = c('ae_0000_msajc003_999', '0000', 'msajc003', 'Phonetic2', 999, 'SEGMENT', 1, 20000, NA, 3800, 200, 'testLabel12')
  res = autobuild.linkFromTimes(ae, 'Phonetic', 'Phonetic2', FALSE)
  expect_equal(res$links[786,]$fromID, 147)
  expect_equal(res$links[786,]$toID, 999)
    
  # add item to Phonetic2 = left overlap
  ae$items[737, ] = c('ae_0000_msajc003_999', '0000', 'msajc003', 'Phonetic2', 999, 'SEGMENT', 1, 20000, NA, 3500, 1000, 'testLabel12')
  res = autobuild.linkFromTimes(ae, 'Phonetic', 'Phonetic2', FALSE)
  expect_equal(dim(res$links)[1], 785)
  
  # add item to Phonetic2 = right overlap
  ae$items[741, ] = c('ae_0000_msajc003_999', '0000', 'msajc003', 'Phonetic2', 999, 'SEGMENT', 1, 20000, NA, 3800, 2000, 'testLabel12')
  res = autobuild.linkFromTimes(ae, 'Phonetic', 'Phonetic2', FALSE)
  expect_equal(dim(res$links)[1], 785)
  
})

# TODO CHECK FOR DUPLICATES

##############################
test_that("correct links are present after autobuild.linkFromTimes with SEGMENTS linkDef type MANY_TO_MANY", {
  # add linkDef.
  tmpLinkDef = create.schema.linkDefinition(type='MANY_TO_MANY', superlevelName='Phonetic', sublevelName='Phonetic2')
  ae$DBconfig$linkDefinitions[[length(ae$DBconfig$linkDefinitions) + 1]] = tmpLinkDef
  
  # add levelDef.
  tmpLevelDef = create.schema.levelDefinition(name = 'Phonetic2', type = 'SEGMENT', attributeDefinitions = list())
  ae$DBconfig$levelDefinitions[[length(ae$DBconfig$levelDefinitions) + 1]] = tmpLevelDef
  
  # add item to Phonetic2 = completely within
  ae$items[737, ] = c('ae_0000_msajc003_999', '0000', 'msajc003', 'Phonetic2', 999, 'SEGMENT', 1, 20000, NA, 3800, 200, 'testLabel12')
  res = autobuild.linkFromTimes(ae, 'Phonetic', 'Phonetic2', FALSE)
  expect_equal(res$links[786,]$fromID, 147)
  expect_equal(res$links[786,]$toID, 999)
  
  # add item to Phonetic2 = left overlap
  ae$items[737, ] = c('ae_0000_msajc003_999', '0000', 'msajc003', 'Phonetic2', 999, 'SEGMENT', 1, 20000, NA, 3500, 1000, 'testLabel12')
  res = autobuild.linkFromTimes(ae, 'Phonetic', 'Phonetic2', FALSE)
  expect_equal(res$links[786,]$fromID, 147)
  expect_equal(res$links[786,]$toID, 999)
  
  # add item to Phonetic2 = right overlap
  ae$items[737, ] = c('ae_0000_msajc003_999', '0000', 'msajc003', 'Phonetic2', 999, 'SEGMENT', 1, 20000, NA, 3800, 2000, 'testLabel12')
  res = autobuild.linkFromTimes(ae, 'Phonetic', 'Phonetic2', FALSE)
  expect_equal(res$links[786,]$fromID, 147)
  expect_equal(res$links[786,]$toID, 999)
  expect_equal(res$links[787,]$fromID, 148)
  expect_equal(res$links[787,]$toID, 999)
  
  
  # add item to Phonetic2 = left and right overlap
  ae$items[737, ] = c('ae_0000_msajc003_999', '0000', 'msajc003', 'Phonetic2', 999, 'SEGMENT', 1, 20000, NA, 3500, 2000, 'testLabel12')
  res = autobuild.linkFromTimes(ae, 'Phonetic', 'Phonetic2', FALSE)
  expect_equal(res$links[786,]$fromID, 147)
  expect_equal(res$links[786,]$toID, 999)
  expect_equal(res$links[787,]$fromID, 148)
  expect_equal(res$links[787,]$toID, 999)
  
  
  # add item to Phonetic2 = not within
  ae$items[737, ] = c('ae_0000_msajc003_999', '0000', 'msajc003', 'Phonetic2', 999, 'SEGMENT', 1, 20000, NA, 200, 200, 'testLabel12')
  res = autobuild.linkFromTimes(ae, 'Phonetic', 'Phonetic2', FALSE)
  expect_equal(dim(res$links)[1], 785)
  
})

##############################
test_that("correct links are present after autobuild.linkFromTimes with SEGMENTS linkDef type ONE_TO_ONE", {
  # add linkDef.
  tmpLinkDef = create.schema.linkDefinition(type='ONE_TO_ONE', superlevelName='Phonetic', sublevelName='Phonetic2')
  ae$DBconfig$linkDefinitions[[length(ae$DBconfig$linkDefinitions) + 1]] = tmpLinkDef
  
  # add levelDef.
  tmpLevelDef = create.schema.levelDefinition(name = 'Phonetic2', type = 'SEGMENT', attributeDefinitions = list())
  ae$DBconfig$levelDefinitions[[length(ae$DBconfig$levelDefinitions) + 1]] = tmpLevelDef
  
  # add item to Phonetic2 = exact match
  ae$items[737, ] = c('ae_0000_msajc003_999', '0000', 'msajc003', 'Phonetic2', 999, 'SEGMENT', 1, 20000, NA, 3749, 1389, 'testLabel12')
  res = autobuild.linkFromTimes(ae, 'Phonetic', 'Phonetic2', FALSE)
  expect_equal(res$links[786,]$fromID, 147)
  expect_equal(res$links[786,]$toID, 999)
  
  # add item to Phonetic2 = left overlap
  ae$items[737, ] = c('ae_0000_msajc003_999', '0000', 'msajc003', 'Phonetic2', 999, 'SEGMENT', 1, 20000, NA, 3748, 1389, 'testLabel12')
  res = autobuild.linkFromTimes(ae, 'Phonetic', 'Phonetic2', FALSE)
  expect_equal(dim(res$links)[1], 785)

  # add item to Phonetic2 = right overlap
  ae$items[737, ] = c('ae_0000_msajc003_999', '0000', 'msajc003', 'Phonetic2', 999, 'SEGMENT', 1, 20000, NA, 3749, 1390, 'testLabel12')
  res = autobuild.linkFromTimes(ae, 'Phonetic', 'Phonetic2', FALSE)
  expect_equal(dim(res$links)[1], 785)

  # add item to Phonetic2 = within
  ae$items[737, ] = c('ae_0000_msajc003_999', '0000', 'msajc003', 'Phonetic2', 999, 'SEGMENT', 1, 20000, NA, 3750, 200, 'testLabel12')
  res = autobuild.linkFromTimes(ae, 'Phonetic', 'Phonetic2', FALSE)
  expect_equal(dim(res$links)[1], 785)
  
  # add item to Phonetic2 = not within
  ae$items[737, ] = c('ae_0000_msajc003_999', '0000', 'msajc003', 'Phonetic2', 999, 'SEGMENT', 1, 20000, NA, 200, 200, 'testLabel12')
  res = autobuild.linkFromTimes(ae, 'Phonetic', 'Phonetic2', FALSE)
  expect_equal(dim(res$links)[1], 785)
  
})