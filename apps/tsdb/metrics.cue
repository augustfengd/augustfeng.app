#metric: {
	labels: {
		[string]: string
	} | *null
	interval: int | *30
	sample: {
		values: [...int]
		timestamps: [ for i, value in sample.values {
			if i == 0 {
				int | *0
			}
			if i > 0 {
				int | *(sample.timestamps[i-1] + interval)
			}
		}]
	}
}

metrics: {[string]: #metric} & {
	foobar: {
		labels: "hello": "world"
		sample: values: [1, 2, 3, 4, 5]
		sample: timestamps: [0, ...]
	}
}
