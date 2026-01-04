const compressImage = (file, maxWidth = 500, quality = 0.6) => {
    return new Promise((resolve) => {
        const reader = new FileReader()
        reader.readAsDataURL(file)

        reader.onload = (e) => {
            const img = new Image()
            img.src = e.target.result

            img.onload = () => {
                const canvas = document.createElement('canvas')
                const ctx = canvas.getContext('2d')

                // resize proporsional
                const scale = maxWidth / img.width
                canvas.width = maxWidth
                canvas.height = img.height * scale

                ctx.drawImage(img, 0, 0, canvas.width, canvas.height)

                const compressedBase64 = canvas.toDataURL(
                    'image/jpeg',
                    quality
                )

                resolve(compressedBase64)
            }
        }
    })
}

export default compressImage