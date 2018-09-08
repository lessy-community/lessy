import auth from '../auth'

function parseJson (response) {
  if (response.status === 204) {
    // Response is 204 No Content
    return {
      data: {},
      status: response.status,
    }
  }

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

function get (url, options = { authorization: 'normal' }) {
  const { authorization } = options
  const fetchOptions = {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json',
    },
  }
  if (authorization !== 'none') {
    fetchOptions['headers']['Authorization'] = auth.getToken(authorization)
  }
  return window.fetch(url, fetchOptions)
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

function post (url, payload, options = { authorization: 'normal' }) {
  const { authorization } = options
  const fetchOptions = {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(payload),
  }
  if (authorization !== 'none') {
    fetchOptions['headers']['Authorization'] = auth.getToken(authorization)
  }
  return window.fetch(url, fetchOptions)
               .then(parseJson)
               .then(handleErrors)
}

function patch (url, payload, options = { authorization: 'normal' }) {
  const { authorization } = options
  const fetchOptions = {
    method: 'PATCH',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(payload),
  }
  if (authorization !== 'none') {
    fetchOptions['headers']['Authorization'] = auth.getToken(authorization)
  }
  return window.fetch(url, fetchOptions)
               .then(parseJson)
               .then(handleErrors)
}

function put (url, payload, options = { authorization: 'normal' }) {
  const { authorization } = options
  const fetchOptions = {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(payload),
  }
  if (authorization !== 'none') {
    fetchOptions['headers']['Authorization'] = auth.getToken(authorization)
  }
  return window.fetch(url, fetchOptions)
               .then(parseJson)
               .then(handleErrors)
}

function destroy (url, payload, options = { authorization: 'normal' }) {
  const { authorization } = options
  const fetchOptions = {
    method: 'DELETE',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(payload),
  }
  if (authorization !== 'none') {
    fetchOptions['headers']['Authorization'] = auth.getToken(authorization)
  }
  return window.fetch(url, fetchOptions)
               .then(parseJson)
               .then(handleErrors)
}

export {
  get,
  post,
  patch,
  put,
  destroy,
  getWhileNext,
}
