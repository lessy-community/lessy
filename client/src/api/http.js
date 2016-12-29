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

function post (url, payload) {
  const options = {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(payload),
  }
  return window.fetch(url, options)
               .then(parseJson)
               .then(handleErrors)
}

export {
  post
}
