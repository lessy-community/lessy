import auth from '../auth'

function parseJson (response) {
  return response.json().then((json) => {
    return {
      data: json,
      status: response.status,
    }
  })
}

function handleErrors ({data, status}) {
  if (status >= 200 && status < 300) {
    return data
  } else {
    let error = new Error('request failed, error ' + status)
    error.data = data
    throw error
  }
}

function get (url, needAuthorization = true) {
  const options = {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json',
    },
  }
  if (needAuthorization) {
    options['headers']['Authorization'] = auth.getToken()
  }
  return window.fetch(url, options)
               .then(parseJson)
               .then(handleErrors)
}

function getWhileNext (callback) {
  function crawl (res) {
    callback(res)
    if (res.links.next != null) {
      return get(res.links.next).then(crawl)
    }
    return res
  }

  return crawl
}

function post (url, payload, needAuthorization = true) {
  const options = {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(payload),
  }
  if (needAuthorization) {
    options['headers']['Authorization'] = auth.getToken()
  }
  return window.fetch(url, options)
               .then(parseJson)
               .then(handleErrors)
}

function patch (url, payload) {
  const options = {
    method: 'PATCH',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': auth.getToken(),
    },
    body: JSON.stringify(payload),
  }
  return window.fetch(url, options)
               .then(parseJson)
               .then(handleErrors)
}

function put (url, payload) {
  const options = {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': auth.getToken(),
    },
    body: JSON.stringify(payload),
  }
  return window.fetch(url, options)
               .then(parseJson)
               .then(handleErrors)
}

export {
  get,
  post,
  patch,
  put,
  getWhileNext,
}
