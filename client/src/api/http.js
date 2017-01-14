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
    options['headers']['Authorization'] = window.localStorage.getItem('authentication_token')
  }
  return window.fetch(url, options)
               .then(parseJson)
               .then(handleErrors)
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
    options['headers']['Authorization'] = window.localStorage.getItem('authentication_token')
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
      'Authorization': window.localStorage.getItem('authentication_token'),
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
}
