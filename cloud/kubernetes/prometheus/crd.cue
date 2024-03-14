package prometheus

crd: manifests: [{
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: {
			"controller-gen.kubebuilder.io/version": "v0.13.0"
			"operator.prometheus.io/version":        "0.72.0"
		}
		name: "alertmanagerconfigs.monitoring.coreos.com"
	}
	spec: {
		group: "monitoring.coreos.com"
		names: {
			categories: [
				"prometheus-operator",
			]
			kind:     "AlertmanagerConfig"
			listKind: "AlertmanagerConfigList"
			plural:   "alertmanagerconfigs"
			shortNames: [
				"amcfg",
			]
			singular: "alertmanagerconfig"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				properties: {
					apiVersion: type: "string"
					kind: type: "string"
					metadata: type: "object"
					spec: {
						properties: {
							inhibitRules: {
								items: {
									properties: {
										equal: {
											items: type: "string"
											type: "array"
										}
										sourceMatch: {
											items: {
												properties: {
													matchType: {
														enum: [
															"!=",
															"=",
															"=~",
															"!~",
														]
														type: "string"
													}
													name: {
														minLength: 1
														type:      "string"
													}
													regex: type: "boolean"
													value: type: "string"
												}
												required: [
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										targetMatch: {
											items: {
												properties: {
													matchType: {
														enum: [
															"!=",
															"=",
															"=~",
															"!~",
														]
														type: "string"
													}
													name: {
														minLength: 1
														type:      "string"
													}
													regex: type: "boolean"
													value: type: "string"
												}
												required: [
													"name",
												]
												type: "object"
											}
											type: "array"
										}
									}
									type: "object"
								}
								type: "array"
							}
							muteTimeIntervals: {
								items: {
									properties: {
										name: type: "string"
										timeIntervals: {
											items: {
												properties: {
													daysOfMonth: {
														items: {
															properties: {
																end: {
																	maximum: 31
																	minimum: -31
																	type:    "integer"
																}
																start: {
																	maximum: 31
																	minimum: -31
																	type:    "integer"
																}
															}
															type: "object"
														}
														type: "array"
													}
													months: {
														items: {
															pattern: "^((?i)january|february|march|april|may|june|july|august|september|october|november|december|[1-12])(?:((:((?i)january|february|march|april|may|june|july|august|september|october|november|december|[1-12]))$)|$)"
															type:    "string"
														}
														type: "array"
													}
													times: {
														items: {
															properties: {
																endTime: {
																	pattern: "^((([01][0-9])|(2[0-3])):[0-5][0-9])$|(^24:00$)"
																	type:    "string"
																}
																startTime: {
																	pattern: "^((([01][0-9])|(2[0-3])):[0-5][0-9])$|(^24:00$)"
																	type:    "string"
																}
															}
															type: "object"
														}
														type: "array"
													}
													weekdays: {
														items: {
															pattern: "^((?i)sun|mon|tues|wednes|thurs|fri|satur)day(?:((:(sun|mon|tues|wednes|thurs|fri|satur)day)$)|$)"
															type:    "string"
														}
														type: "array"
													}
													years: {
														items: {
															pattern: "^2\\d{3}(?::2\\d{3}|$)"
															type:    "string"
														}
														type: "array"
													}
												}
												type: "object"
											}
											type: "array"
										}
									}
									type: "object"
								}
								type: "array"
							}
							receivers: {
								items: {
									properties: {
										discordConfigs: {
											items: {
												properties: {
													apiURL: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													httpConfig: {
														properties: {
															authorization: {
																properties: {
																	credentials: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	type: type: "string"
																}
																type: "object"
															}
															basicAuth: {
																properties: {
																	password: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	username: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																}
																type: "object"
															}
															bearerTokenSecret: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															followRedirects: type: "boolean"
															oauth2: {
																properties: {
																	clientId: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	clientSecret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	endpointParams: {
																		additionalProperties: type: "string"
																		type: "object"
																	}
																	scopes: {
																		items: type: "string"
																		type: "array"
																	}
																	tokenUrl: {
																		minLength: 1
																		type:      "string"
																	}
																}
																required: [
																	"clientId",
																	"clientSecret",
																	"tokenUrl",
																]
																type: "object"
															}
															proxyURL: type: "string"
															tlsConfig: {
																properties: {
																	ca: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	cert: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	insecureSkipVerify: type: "boolean"
																	keySecret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	serverName: type: "string"
																}
																type: "object"
															}
														}
														type: "object"
													}
													message: type: "string"
													sendResolved: type: "boolean"
													title: type: "string"
												}
												required: [
													"apiURL",
												]
												type: "object"
											}
											type: "array"
										}
										emailConfigs: {
											items: {
												properties: {
													authIdentity: type: "string"
													authPassword: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													authSecret: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													authUsername: type: "string"
													from: type: "string"
													headers: {
														items: {
															properties: {
																key: {
																	minLength: 1
																	type:      "string"
																}
																value: type: "string"
															}
															required: [
																"key",
																"value",
															]
															type: "object"
														}
														type: "array"
													}
													hello: type: "string"
													html: type: "string"
													requireTLS: type: "boolean"
													sendResolved: type: "boolean"
													smarthost: type: "string"
													text: type: "string"
													tlsConfig: {
														properties: {
															ca: {
																properties: {
																	configMap: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	secret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																}
																type: "object"
															}
															cert: {
																properties: {
																	configMap: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	secret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																}
																type: "object"
															}
															insecureSkipVerify: type: "boolean"
															keySecret: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															serverName: type: "string"
														}
														type: "object"
													}
													to: type: "string"
												}
												type: "object"
											}
											type: "array"
										}
										msteamsConfigs: {
											items: {
												properties: {
													httpConfig: {
														properties: {
															authorization: {
																properties: {
																	credentials: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	type: type: "string"
																}
																type: "object"
															}
															basicAuth: {
																properties: {
																	password: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	username: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																}
																type: "object"
															}
															bearerTokenSecret: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															followRedirects: type: "boolean"
															oauth2: {
																properties: {
																	clientId: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	clientSecret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	endpointParams: {
																		additionalProperties: type: "string"
																		type: "object"
																	}
																	scopes: {
																		items: type: "string"
																		type: "array"
																	}
																	tokenUrl: {
																		minLength: 1
																		type:      "string"
																	}
																}
																required: [
																	"clientId",
																	"clientSecret",
																	"tokenUrl",
																]
																type: "object"
															}
															proxyURL: type: "string"
															tlsConfig: {
																properties: {
																	ca: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	cert: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	insecureSkipVerify: type: "boolean"
																	keySecret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	serverName: type: "string"
																}
																type: "object"
															}
														}
														type: "object"
													}
													sendResolved: type: "boolean"
													text: type: "string"
													title: type: "string"
													webhookUrl: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												required: [
													"webhookUrl",
												]
												type: "object"
											}
											type: "array"
										}
										name: {
											minLength: 1
											type:      "string"
										}
										opsgenieConfigs: {
											items: {
												properties: {
													actions: type: "string"
													apiKey: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													apiURL: type: "string"
													description: type: "string"
													details: {
														items: {
															properties: {
																key: {
																	minLength: 1
																	type:      "string"
																}
																value: type: "string"
															}
															required: [
																"key",
																"value",
															]
															type: "object"
														}
														type: "array"
													}
													entity: type: "string"
													httpConfig: {
														properties: {
															authorization: {
																properties: {
																	credentials: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	type: type: "string"
																}
																type: "object"
															}
															basicAuth: {
																properties: {
																	password: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	username: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																}
																type: "object"
															}
															bearerTokenSecret: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															followRedirects: type: "boolean"
															oauth2: {
																properties: {
																	clientId: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	clientSecret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	endpointParams: {
																		additionalProperties: type: "string"
																		type: "object"
																	}
																	scopes: {
																		items: type: "string"
																		type: "array"
																	}
																	tokenUrl: {
																		minLength: 1
																		type:      "string"
																	}
																}
																required: [
																	"clientId",
																	"clientSecret",
																	"tokenUrl",
																]
																type: "object"
															}
															proxyURL: type: "string"
															tlsConfig: {
																properties: {
																	ca: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	cert: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	insecureSkipVerify: type: "boolean"
																	keySecret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	serverName: type: "string"
																}
																type: "object"
															}
														}
														type: "object"
													}
													message: type: "string"
													note: type: "string"
													priority: type: "string"
													responders: {
														items: {
															properties: {
																id: type: "string"
																name: type: "string"
																type: {
																	enum: [
																		"team",
																		"teams",
																		"user",
																		"escalation",
																		"schedule",
																	]
																	minLength: 1
																	type:      "string"
																}
																username: type: "string"
															}
															required: [
																"type",
															]
															type: "object"
														}
														type: "array"
													}
													sendResolved: type: "boolean"
													source: type: "string"
													tags: type: "string"
													updateAlerts: type: "boolean"
												}
												type: "object"
											}
											type: "array"
										}
										pagerdutyConfigs: {
											items: {
												properties: {
													class: type: "string"
													client: type: "string"
													clientURL: type: "string"
													component: type: "string"
													description: type: "string"
													details: {
														items: {
															properties: {
																key: {
																	minLength: 1
																	type:      "string"
																}
																value: type: "string"
															}
															required: [
																"key",
																"value",
															]
															type: "object"
														}
														type: "array"
													}
													group: type: "string"
													httpConfig: {
														properties: {
															authorization: {
																properties: {
																	credentials: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	type: type: "string"
																}
																type: "object"
															}
															basicAuth: {
																properties: {
																	password: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	username: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																}
																type: "object"
															}
															bearerTokenSecret: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															followRedirects: type: "boolean"
															oauth2: {
																properties: {
																	clientId: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	clientSecret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	endpointParams: {
																		additionalProperties: type: "string"
																		type: "object"
																	}
																	scopes: {
																		items: type: "string"
																		type: "array"
																	}
																	tokenUrl: {
																		minLength: 1
																		type:      "string"
																	}
																}
																required: [
																	"clientId",
																	"clientSecret",
																	"tokenUrl",
																]
																type: "object"
															}
															proxyURL: type: "string"
															tlsConfig: {
																properties: {
																	ca: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	cert: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	insecureSkipVerify: type: "boolean"
																	keySecret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	serverName: type: "string"
																}
																type: "object"
															}
														}
														type: "object"
													}
													pagerDutyImageConfigs: {
														items: {
															properties: {
																alt: type: "string"
																href: type: "string"
																src: type: "string"
															}
															type: "object"
														}
														type: "array"
													}
													pagerDutyLinkConfigs: {
														items: {
															properties: {
																alt: type: "string"
																href: type: "string"
															}
															type: "object"
														}
														type: "array"
													}
													routingKey: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													sendResolved: type: "boolean"
													serviceKey: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													severity: type: "string"
													url: type: "string"
												}
												type: "object"
											}
											type: "array"
										}
										pushoverConfigs: {
											items: {
												properties: {
													device: type: "string"
													expire: {
														pattern: "^(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?$"
														type:    "string"
													}
													html: type: "boolean"
													httpConfig: {
														properties: {
															authorization: {
																properties: {
																	credentials: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	type: type: "string"
																}
																type: "object"
															}
															basicAuth: {
																properties: {
																	password: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	username: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																}
																type: "object"
															}
															bearerTokenSecret: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															followRedirects: type: "boolean"
															oauth2: {
																properties: {
																	clientId: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	clientSecret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	endpointParams: {
																		additionalProperties: type: "string"
																		type: "object"
																	}
																	scopes: {
																		items: type: "string"
																		type: "array"
																	}
																	tokenUrl: {
																		minLength: 1
																		type:      "string"
																	}
																}
																required: [
																	"clientId",
																	"clientSecret",
																	"tokenUrl",
																]
																type: "object"
															}
															proxyURL: type: "string"
															tlsConfig: {
																properties: {
																	ca: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	cert: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	insecureSkipVerify: type: "boolean"
																	keySecret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	serverName: type: "string"
																}
																type: "object"
															}
														}
														type: "object"
													}
													message: type: "string"
													priority: type: "string"
													retry: {
														pattern: "^(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?$"
														type:    "string"
													}
													sendResolved: type: "boolean"
													sound: type: "string"
													title: type: "string"
													token: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													tokenFile: type: "string"
													url: type: "string"
													urlTitle: type: "string"
													userKey: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													userKeyFile: type: "string"
												}
												type: "object"
											}
											type: "array"
										}
										slackConfigs: {
											items: {
												properties: {
													actions: {
														items: {
															properties: {
																confirm: {
																	properties: {
																		dismissText: type: "string"
																		okText: type: "string"
																		text: {
																			minLength: 1
																			type:      "string"
																		}
																		title: type: "string"
																	}
																	required: [
																		"text",
																	]
																	type: "object"
																}
																name: type: "string"
																style: type: "string"
																text: {
																	minLength: 1
																	type:      "string"
																}
																type: {
																	minLength: 1
																	type:      "string"
																}
																url: type: "string"
																value: type: "string"
															}
															required: [
																"text",
																"type",
															]
															type: "object"
														}
														type: "array"
													}
													apiURL: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													callbackId: type: "string"
													channel: type: "string"
													color: type: "string"
													fallback: type: "string"
													fields: {
														items: {
															properties: {
																short: type: "boolean"
																title: {
																	minLength: 1
																	type:      "string"
																}
																value: {
																	minLength: 1
																	type:      "string"
																}
															}
															required: [
																"title",
																"value",
															]
															type: "object"
														}
														type: "array"
													}
													footer: type: "string"
													httpConfig: {
														properties: {
															authorization: {
																properties: {
																	credentials: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	type: type: "string"
																}
																type: "object"
															}
															basicAuth: {
																properties: {
																	password: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	username: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																}
																type: "object"
															}
															bearerTokenSecret: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															followRedirects: type: "boolean"
															oauth2: {
																properties: {
																	clientId: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	clientSecret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	endpointParams: {
																		additionalProperties: type: "string"
																		type: "object"
																	}
																	scopes: {
																		items: type: "string"
																		type: "array"
																	}
																	tokenUrl: {
																		minLength: 1
																		type:      "string"
																	}
																}
																required: [
																	"clientId",
																	"clientSecret",
																	"tokenUrl",
																]
																type: "object"
															}
															proxyURL: type: "string"
															tlsConfig: {
																properties: {
																	ca: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	cert: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	insecureSkipVerify: type: "boolean"
																	keySecret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	serverName: type: "string"
																}
																type: "object"
															}
														}
														type: "object"
													}
													iconEmoji: type: "string"
													iconURL: type: "string"
													imageURL: type: "string"
													linkNames: type: "boolean"
													mrkdwnIn: {
														items: type: "string"
														type: "array"
													}
													pretext: type: "string"
													sendResolved: type: "boolean"
													shortFields: type: "boolean"
													text: type: "string"
													thumbURL: type: "string"
													title: type: "string"
													titleLink: type: "string"
													username: type: "string"
												}
												type: "object"
											}
											type: "array"
										}
										snsConfigs: {
											items: {
												properties: {
													apiURL: type: "string"
													attributes: {
														additionalProperties: type: "string"
														type: "object"
													}
													httpConfig: {
														properties: {
															authorization: {
																properties: {
																	credentials: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	type: type: "string"
																}
																type: "object"
															}
															basicAuth: {
																properties: {
																	password: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	username: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																}
																type: "object"
															}
															bearerTokenSecret: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															followRedirects: type: "boolean"
															oauth2: {
																properties: {
																	clientId: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	clientSecret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	endpointParams: {
																		additionalProperties: type: "string"
																		type: "object"
																	}
																	scopes: {
																		items: type: "string"
																		type: "array"
																	}
																	tokenUrl: {
																		minLength: 1
																		type:      "string"
																	}
																}
																required: [
																	"clientId",
																	"clientSecret",
																	"tokenUrl",
																]
																type: "object"
															}
															proxyURL: type: "string"
															tlsConfig: {
																properties: {
																	ca: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	cert: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	insecureSkipVerify: type: "boolean"
																	keySecret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	serverName: type: "string"
																}
																type: "object"
															}
														}
														type: "object"
													}
													message: type: "string"
													phoneNumber: type: "string"
													sendResolved: type: "boolean"
													sigv4: {
														properties: {
															accessKey: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															profile: type: "string"
															region: type: "string"
															roleArn: type: "string"
															secretKey: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
														}
														type: "object"
													}
													subject: type: "string"
													targetARN: type: "string"
													topicARN: type: "string"
												}
												type: "object"
											}
											type: "array"
										}
										telegramConfigs: {
											items: {
												properties: {
													apiURL: type: "string"
													botToken: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													botTokenFile: type: "string"
													chatID: {
														format: "int64"
														type:   "integer"
													}
													disableNotifications: type: "boolean"
													httpConfig: {
														properties: {
															authorization: {
																properties: {
																	credentials: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	type: type: "string"
																}
																type: "object"
															}
															basicAuth: {
																properties: {
																	password: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	username: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																}
																type: "object"
															}
															bearerTokenSecret: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															followRedirects: type: "boolean"
															oauth2: {
																properties: {
																	clientId: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	clientSecret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	endpointParams: {
																		additionalProperties: type: "string"
																		type: "object"
																	}
																	scopes: {
																		items: type: "string"
																		type: "array"
																	}
																	tokenUrl: {
																		minLength: 1
																		type:      "string"
																	}
																}
																required: [
																	"clientId",
																	"clientSecret",
																	"tokenUrl",
																]
																type: "object"
															}
															proxyURL: type: "string"
															tlsConfig: {
																properties: {
																	ca: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	cert: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	insecureSkipVerify: type: "boolean"
																	keySecret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	serverName: type: "string"
																}
																type: "object"
															}
														}
														type: "object"
													}
													message: type: "string"
													parseMode: {
														enum: [
															"MarkdownV2",
															"Markdown",
															"HTML",
														]
														type: "string"
													}
													sendResolved: type: "boolean"
												}
												type: "object"
											}
											type: "array"
										}
										victoropsConfigs: {
											items: {
												properties: {
													apiKey: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													apiUrl: type: "string"
													customFields: {
														items: {
															properties: {
																key: {
																	minLength: 1
																	type:      "string"
																}
																value: type: "string"
															}
															required: [
																"key",
																"value",
															]
															type: "object"
														}
														type: "array"
													}
													entityDisplayName: type: "string"
													httpConfig: {
														properties: {
															authorization: {
																properties: {
																	credentials: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	type: type: "string"
																}
																type: "object"
															}
															basicAuth: {
																properties: {
																	password: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	username: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																}
																type: "object"
															}
															bearerTokenSecret: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															followRedirects: type: "boolean"
															oauth2: {
																properties: {
																	clientId: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	clientSecret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	endpointParams: {
																		additionalProperties: type: "string"
																		type: "object"
																	}
																	scopes: {
																		items: type: "string"
																		type: "array"
																	}
																	tokenUrl: {
																		minLength: 1
																		type:      "string"
																	}
																}
																required: [
																	"clientId",
																	"clientSecret",
																	"tokenUrl",
																]
																type: "object"
															}
															proxyURL: type: "string"
															tlsConfig: {
																properties: {
																	ca: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	cert: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	insecureSkipVerify: type: "boolean"
																	keySecret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	serverName: type: "string"
																}
																type: "object"
															}
														}
														type: "object"
													}
													messageType: type: "string"
													monitoringTool: type: "string"
													routingKey: type: "string"
													sendResolved: type: "boolean"
													stateMessage: type: "string"
												}
												type: "object"
											}
											type: "array"
										}
										webexConfigs: {
											items: {
												properties: {
													apiURL: {
														pattern: "^https?://.+$"
														type:    "string"
													}
													httpConfig: {
														properties: {
															authorization: {
																properties: {
																	credentials: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	type: type: "string"
																}
																type: "object"
															}
															basicAuth: {
																properties: {
																	password: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	username: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																}
																type: "object"
															}
															bearerTokenSecret: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															followRedirects: type: "boolean"
															oauth2: {
																properties: {
																	clientId: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	clientSecret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	endpointParams: {
																		additionalProperties: type: "string"
																		type: "object"
																	}
																	scopes: {
																		items: type: "string"
																		type: "array"
																	}
																	tokenUrl: {
																		minLength: 1
																		type:      "string"
																	}
																}
																required: [
																	"clientId",
																	"clientSecret",
																	"tokenUrl",
																]
																type: "object"
															}
															proxyURL: type: "string"
															tlsConfig: {
																properties: {
																	ca: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	cert: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	insecureSkipVerify: type: "boolean"
																	keySecret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	serverName: type: "string"
																}
																type: "object"
															}
														}
														type: "object"
													}
													message: type: "string"
													roomID: {
														minLength: 1
														type:      "string"
													}
													sendResolved: type: "boolean"
												}
												required: [
													"roomID",
												]
												type: "object"
											}
											type: "array"
										}
										webhookConfigs: {
											items: {
												properties: {
													httpConfig: {
														properties: {
															authorization: {
																properties: {
																	credentials: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	type: type: "string"
																}
																type: "object"
															}
															basicAuth: {
																properties: {
																	password: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	username: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																}
																type: "object"
															}
															bearerTokenSecret: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															followRedirects: type: "boolean"
															oauth2: {
																properties: {
																	clientId: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	clientSecret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	endpointParams: {
																		additionalProperties: type: "string"
																		type: "object"
																	}
																	scopes: {
																		items: type: "string"
																		type: "array"
																	}
																	tokenUrl: {
																		minLength: 1
																		type:      "string"
																	}
																}
																required: [
																	"clientId",
																	"clientSecret",
																	"tokenUrl",
																]
																type: "object"
															}
															proxyURL: type: "string"
															tlsConfig: {
																properties: {
																	ca: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	cert: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	insecureSkipVerify: type: "boolean"
																	keySecret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	serverName: type: "string"
																}
																type: "object"
															}
														}
														type: "object"
													}
													maxAlerts: {
														format:  "int32"
														minimum: 0
														type:    "integer"
													}
													sendResolved: type: "boolean"
													url: type: "string"
													urlSecret: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											type: "array"
										}
										wechatConfigs: {
											items: {
												properties: {
													agentID: type: "string"
													apiSecret: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													apiURL: type: "string"
													corpID: type: "string"
													httpConfig: {
														properties: {
															authorization: {
																properties: {
																	credentials: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	type: type: "string"
																}
																type: "object"
															}
															basicAuth: {
																properties: {
																	password: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	username: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																}
																type: "object"
															}
															bearerTokenSecret: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															followRedirects: type: "boolean"
															oauth2: {
																properties: {
																	clientId: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	clientSecret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	endpointParams: {
																		additionalProperties: type: "string"
																		type: "object"
																	}
																	scopes: {
																		items: type: "string"
																		type: "array"
																	}
																	tokenUrl: {
																		minLength: 1
																		type:      "string"
																	}
																}
																required: [
																	"clientId",
																	"clientSecret",
																	"tokenUrl",
																]
																type: "object"
															}
															proxyURL: type: "string"
															tlsConfig: {
																properties: {
																	ca: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	cert: {
																		properties: {
																			configMap: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			secret: {
																				properties: {
																					key: type: "string"
																					name: type: "string"
																					optional: type: "boolean"
																				}
																				required: [
																					"key",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		type: "object"
																	}
																	insecureSkipVerify: type: "boolean"
																	keySecret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	serverName: type: "string"
																}
																type: "object"
															}
														}
														type: "object"
													}
													message: type: "string"
													messageType: type: "string"
													sendResolved: type: "boolean"
													toParty: type: "string"
													toTag: type: "string"
													toUser: type: "string"
												}
												type: "object"
											}
											type: "array"
										}
									}
									required: [
										"name",
									]
									type: "object"
								}
								type: "array"
							}
							route: {
								properties: {
									activeTimeIntervals: {
										items: type: "string"
										type: "array"
									}
									continue: type: "boolean"
									groupBy: {
										items: type: "string"
										type: "array"
									}
									groupInterval: type: "string"
									groupWait: type: "string"
									matchers: {
										items: {
											properties: {
												matchType: {
													enum: [
														"!=",
														"=",
														"=~",
														"!~",
													]
													type: "string"
												}
												name: {
													minLength: 1
													type:      "string"
												}
												regex: type: "boolean"
												value: type: "string"
											}
											required: [
												"name",
											]
											type: "object"
										}
										type: "array"
									}
									muteTimeIntervals: {
										items: type: "string"
										type: "array"
									}
									receiver: type: "string"
									repeatInterval: type: "string"
									routes: {
										items: "x-kubernetes-preserve-unknown-fields": true
										type: "array"
									}
								}
								type: "object"
							}
						}
						type: "object"
					}
				}
				required: [
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
		}]
	}
}, {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: {
			"controller-gen.kubebuilder.io/version": "v0.13.0"
			"operator.prometheus.io/version":        "0.72.0"
		}
		name: "alertmanagers.monitoring.coreos.com"
	}
	spec: {
		group: "monitoring.coreos.com"
		names: {
			categories: [
				"prometheus-operator",
			]
			kind:     "Alertmanager"
			listKind: "AlertmanagerList"
			plural:   "alertmanagers"
			shortNames: [
				"am",
			]
			singular: "alertmanager"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".spec.version"
				name:     "Version"
				type:     "string"
			}, {
				jsonPath: ".spec.replicas"
				name:     "Replicas"
				type:     "integer"
			}, {
				jsonPath: ".status.availableReplicas"
				name:     "Ready"
				type:     "integer"
			}, {
				jsonPath: ".status.conditions[?(@.type == 'Reconciled')].status"
				name:     "Reconciled"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type == 'Available')].status"
				name:     "Available"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}, {
				jsonPath: ".status.paused"
				name:     "Paused"
				priority: 1
				type:     "boolean"
			}]
			name: "v1"
			schema: openAPIV3Schema: {
				properties: {
					apiVersion: type: "string"
					kind: type: "string"
					metadata: type: "object"
					spec: {
						properties: {
							additionalPeers: {
								items: type: "string"
								type: "array"
							}
							affinity: {
								properties: {
									nodeAffinity: {
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												items: {
													properties: {
														preference: {
															properties: {
																matchExpressions: {
																	items: {
																		properties: {
																			key: type: "string"
																			operator: type: "string"
																			values: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchFields: {
																	items: {
																		properties: {
																			key: type: "string"
																			operator: type: "string"
																			values: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														weight: {
															format: "int32"
															type:   "integer"
														}
													}
													required: [
														"preference",
														"weight",
													]
													type: "object"
												}
												type: "array"
											}
											requiredDuringSchedulingIgnoredDuringExecution: {
												properties: nodeSelectorTerms: {
													items: {
														properties: {
															matchExpressions: {
																items: {
																	properties: {
																		key: type: "string"
																		operator: type: "string"
																		values: {
																			items: type: "string"
																			type: "array"
																		}
																	}
																	required: [
																		"key",
																		"operator",
																	]
																	type: "object"
																}
																type: "array"
															}
															matchFields: {
																items: {
																	properties: {
																		key: type: "string"
																		operator: type: "string"
																		values: {
																			items: type: "string"
																			type: "array"
																		}
																	}
																	required: [
																		"key",
																		"operator",
																	]
																	type: "object"
																}
																type: "array"
															}
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													type: "array"
												}
												required: [
													"nodeSelectorTerms",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
										}
										type: "object"
									}
									podAffinity: {
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												items: {
													properties: {
														podAffinityTerm: {
															properties: {
																labelSelector: {
																	properties: {
																		matchExpressions: {
																			items: {
																				properties: {
																					key: type: "string"
																					operator: type: "string"
																					values: {
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchLabels: {
																			additionalProperties: type: "string"
																			type: "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																matchLabelKeys: {
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																mismatchLabelKeys: {
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																namespaceSelector: {
																	properties: {
																		matchExpressions: {
																			items: {
																				properties: {
																					key: type: "string"
																					operator: type: "string"
																					values: {
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchLabels: {
																			additionalProperties: type: "string"
																			type: "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																namespaces: {
																	items: type: "string"
																	type: "array"
																}
																topologyKey: type: "string"
															}
															required: [
																"topologyKey",
															]
															type: "object"
														}
														weight: {
															format: "int32"
															type:   "integer"
														}
													}
													required: [
														"podAffinityTerm",
														"weight",
													]
													type: "object"
												}
												type: "array"
											}
											requiredDuringSchedulingIgnoredDuringExecution: {
												items: {
													properties: {
														labelSelector: {
															properties: {
																matchExpressions: {
																	items: {
																		properties: {
																			key: type: "string"
																			operator: type: "string"
																			values: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														matchLabelKeys: {
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														mismatchLabelKeys: {
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														namespaceSelector: {
															properties: {
																matchExpressions: {
																	items: {
																		properties: {
																			key: type: "string"
																			operator: type: "string"
																			values: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														namespaces: {
															items: type: "string"
															type: "array"
														}
														topologyKey: type: "string"
													}
													required: [
														"topologyKey",
													]
													type: "object"
												}
												type: "array"
											}
										}
										type: "object"
									}
									podAntiAffinity: {
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												items: {
													properties: {
														podAffinityTerm: {
															properties: {
																labelSelector: {
																	properties: {
																		matchExpressions: {
																			items: {
																				properties: {
																					key: type: "string"
																					operator: type: "string"
																					values: {
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchLabels: {
																			additionalProperties: type: "string"
																			type: "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																matchLabelKeys: {
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																mismatchLabelKeys: {
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																namespaceSelector: {
																	properties: {
																		matchExpressions: {
																			items: {
																				properties: {
																					key: type: "string"
																					operator: type: "string"
																					values: {
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchLabels: {
																			additionalProperties: type: "string"
																			type: "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																namespaces: {
																	items: type: "string"
																	type: "array"
																}
																topologyKey: type: "string"
															}
															required: [
																"topologyKey",
															]
															type: "object"
														}
														weight: {
															format: "int32"
															type:   "integer"
														}
													}
													required: [
														"podAffinityTerm",
														"weight",
													]
													type: "object"
												}
												type: "array"
											}
											requiredDuringSchedulingIgnoredDuringExecution: {
												items: {
													properties: {
														labelSelector: {
															properties: {
																matchExpressions: {
																	items: {
																		properties: {
																			key: type: "string"
																			operator: type: "string"
																			values: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														matchLabelKeys: {
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														mismatchLabelKeys: {
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														namespaceSelector: {
															properties: {
																matchExpressions: {
																	items: {
																		properties: {
																			key: type: "string"
																			operator: type: "string"
																			values: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														namespaces: {
															items: type: "string"
															type: "array"
														}
														topologyKey: type: "string"
													}
													required: [
														"topologyKey",
													]
													type: "object"
												}
												type: "array"
											}
										}
										type: "object"
									}
								}
								type: "object"
							}
							alertmanagerConfigMatcherStrategy: {
								properties: type: {
									default: "OnNamespace"
									enum: [
										"OnNamespace",
										"None",
									]
									type: "string"
								}
								type: "object"
							}
							alertmanagerConfigNamespaceSelector: {
								properties: {
									matchExpressions: {
										items: {
											properties: {
												key: type: "string"
												operator: type: "string"
												values: {
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							alertmanagerConfigSelector: {
								properties: {
									matchExpressions: {
										items: {
											properties: {
												key: type: "string"
												operator: type: "string"
												values: {
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							alertmanagerConfiguration: {
								properties: {
									global: {
										properties: {
											httpConfig: {
												properties: {
													authorization: {
														properties: {
															credentials: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															type: type: "string"
														}
														type: "object"
													}
													basicAuth: {
														properties: {
															password: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															username: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
														}
														type: "object"
													}
													bearerTokenSecret: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													followRedirects: type: "boolean"
													oauth2: {
														properties: {
															clientId: {
																properties: {
																	configMap: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	secret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																}
																type: "object"
															}
															clientSecret: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															endpointParams: {
																additionalProperties: type: "string"
																type: "object"
															}
															scopes: {
																items: type: "string"
																type: "array"
															}
															tokenUrl: {
																minLength: 1
																type:      "string"
															}
														}
														required: [
															"clientId",
															"clientSecret",
															"tokenUrl",
														]
														type: "object"
													}
													proxyURL: type: "string"
													tlsConfig: {
														properties: {
															ca: {
																properties: {
																	configMap: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	secret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																}
																type: "object"
															}
															cert: {
																properties: {
																	configMap: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	secret: {
																		properties: {
																			key: type: "string"
																			name: type: "string"
																			optional: type: "boolean"
																		}
																		required: [
																			"key",
																		]
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																}
																type: "object"
															}
															insecureSkipVerify: type: "boolean"
															keySecret: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															serverName: type: "string"
														}
														type: "object"
													}
												}
												type: "object"
											}
											opsGenieApiKey: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											opsGenieApiUrl: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											pagerdutyUrl: type: "string"
											resolveTimeout: {
												pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
												type:    "string"
											}
											slackApiUrl: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											smtp: {
												properties: {
													authIdentity: type: "string"
													authPassword: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													authSecret: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													authUsername: type: "string"
													from: type: "string"
													hello: type: "string"
													requireTLS: type: "boolean"
													smartHost: {
														properties: {
															host: {
																minLength: 1
																type:      "string"
															}
															port: {
																minLength: 1
																type:      "string"
															}
														}
														required: [
															"host",
															"port",
														]
														type: "object"
													}
												}
												type: "object"
											}
										}
										type: "object"
									}
									name: {
										minLength: 1
										type:      "string"
									}
									templates: {
										items: {
											properties: {
												configMap: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												secret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
											}
											type: "object"
										}
										type: "array"
									}
								}
								type: "object"
							}
							automountServiceAccountToken: type: "boolean"
							baseImage: type: "string"
							clusterAdvertiseAddress: type: "string"
							clusterGossipInterval: {
								pattern: "^(0|(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
								type:    "string"
							}
							clusterLabel: type: "string"
							clusterPeerTimeout: {
								pattern: "^(0|(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
								type:    "string"
							}
							clusterPushpullInterval: {
								pattern: "^(0|(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
								type:    "string"
							}
							configMaps: {
								items: type: "string"
								type: "array"
							}
							configSecret: type: "string"
							containers: {
								items: {
									properties: {
										args: {
											items: type: "string"
											type: "array"
										}
										command: {
											items: type: "string"
											type: "array"
										}
										env: {
											items: {
												properties: {
													name: type: "string"
													value: type: "string"
													valueFrom: {
														properties: {
															configMapKeyRef: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															fieldRef: {
																properties: {
																	apiVersion: type: "string"
																	fieldPath: type: "string"
																}
																required: [
																	"fieldPath",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															resourceFieldRef: {
																properties: {
																	containerName: type: "string"
																	divisor: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	resource: type: "string"
																}
																required: [
																	"resource",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															secretKeyRef: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
														}
														type: "object"
													}
												}
												required: [
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										envFrom: {
											items: {
												properties: {
													configMapRef: {
														properties: {
															name: type: "string"
															optional: type: "boolean"
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													prefix: type: "string"
													secretRef: {
														properties: {
															name: type: "string"
															optional: type: "boolean"
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											type: "array"
										}
										image: type: "string"
										imagePullPolicy: type: "string"
										lifecycle: {
											properties: {
												postStart: {
													properties: {
														exec: {
															properties: command: {
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														httpGet: {
															properties: {
																host: type: "string"
																httpHeaders: {
																	items: {
																		properties: {
																			name: type: "string"
																			value: type: "string"
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																path: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
																scheme: type: "string"
															}
															required: [
																"port",
															]
															type: "object"
														}
														sleep: {
															properties: seconds: {
																format: "int64"
																type:   "integer"
															}
															required: [
																"seconds",
															]
															type: "object"
														}
														tcpSocket: {
															properties: {
																host: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
															}
															required: [
																"port",
															]
															type: "object"
														}
													}
													type: "object"
												}
												preStop: {
													properties: {
														exec: {
															properties: command: {
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														httpGet: {
															properties: {
																host: type: "string"
																httpHeaders: {
																	items: {
																		properties: {
																			name: type: "string"
																			value: type: "string"
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																path: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
																scheme: type: "string"
															}
															required: [
																"port",
															]
															type: "object"
														}
														sleep: {
															properties: seconds: {
																format: "int64"
																type:   "integer"
															}
															required: [
																"seconds",
															]
															type: "object"
														}
														tcpSocket: {
															properties: {
																host: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
															}
															required: [
																"port",
															]
															type: "object"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										livenessProbe: {
											properties: {
												exec: {
													properties: command: {
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													format: "int32"
													type:   "integer"
												}
												grpc: {
													properties: {
														port: {
															format: "int32"
															type:   "integer"
														}
														service: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												httpGet: {
													properties: {
														host: type: "string"
														httpHeaders: {
															items: {
																properties: {
																	name: type: "string"
																	value: type: "string"
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
														scheme: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												initialDelaySeconds: {
													format: "int32"
													type:   "integer"
												}
												periodSeconds: {
													format: "int32"
													type:   "integer"
												}
												successThreshold: {
													format: "int32"
													type:   "integer"
												}
												tcpSocket: {
													properties: {
														host: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
													}
													required: [
														"port",
													]
													type: "object"
												}
												terminationGracePeriodSeconds: {
													format: "int64"
													type:   "integer"
												}
												timeoutSeconds: {
													format: "int32"
													type:   "integer"
												}
											}
											type: "object"
										}
										name: type: "string"
										ports: {
											items: {
												properties: {
													containerPort: {
														format: "int32"
														type:   "integer"
													}
													hostIP: type: "string"
													hostPort: {
														format: "int32"
														type:   "integer"
													}
													name: type: "string"
													protocol: {
														default: "TCP"
														type:    "string"
													}
												}
												required: [
													"containerPort",
												]
												type: "object"
											}
											type: "array"
											"x-kubernetes-list-map-keys": [
												"containerPort",
												"protocol",
											]
											"x-kubernetes-list-type": "map"
										}
										readinessProbe: {
											properties: {
												exec: {
													properties: command: {
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													format: "int32"
													type:   "integer"
												}
												grpc: {
													properties: {
														port: {
															format: "int32"
															type:   "integer"
														}
														service: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												httpGet: {
													properties: {
														host: type: "string"
														httpHeaders: {
															items: {
																properties: {
																	name: type: "string"
																	value: type: "string"
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
														scheme: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												initialDelaySeconds: {
													format: "int32"
													type:   "integer"
												}
												periodSeconds: {
													format: "int32"
													type:   "integer"
												}
												successThreshold: {
													format: "int32"
													type:   "integer"
												}
												tcpSocket: {
													properties: {
														host: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
													}
													required: [
														"port",
													]
													type: "object"
												}
												terminationGracePeriodSeconds: {
													format: "int64"
													type:   "integer"
												}
												timeoutSeconds: {
													format: "int32"
													type:   "integer"
												}
											}
											type: "object"
										}
										resizePolicy: {
											items: {
												properties: {
													resourceName: type: "string"
													restartPolicy: type: "string"
												}
												required: [
													"resourceName",
													"restartPolicy",
												]
												type: "object"
											}
											type:                     "array"
											"x-kubernetes-list-type": "atomic"
										}
										resources: {
											properties: {
												claims: {
													items: {
														properties: name: type: "string"
														required: [
															"name",
														]
														type: "object"
													}
													type: "array"
													"x-kubernetes-list-map-keys": [
														"name",
													]
													"x-kubernetes-list-type": "map"
												}
												limits: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													type: "object"
												}
												requests: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													type: "object"
												}
											}
											type: "object"
										}
										restartPolicy: type: "string"
										securityContext: {
											properties: {
												allowPrivilegeEscalation: type: "boolean"
												capabilities: {
													properties: {
														add: {
															items: type: "string"
															type: "array"
														}
														drop: {
															items: type: "string"
															type: "array"
														}
													}
													type: "object"
												}
												privileged: type: "boolean"
												procMount: type: "string"
												readOnlyRootFilesystem: type: "boolean"
												runAsGroup: {
													format: "int64"
													type:   "integer"
												}
												runAsNonRoot: type: "boolean"
												runAsUser: {
													format: "int64"
													type:   "integer"
												}
												seLinuxOptions: {
													properties: {
														level: type: "string"
														role: type: "string"
														type: type: "string"
														user: type: "string"
													}
													type: "object"
												}
												seccompProfile: {
													properties: {
														localhostProfile: type: "string"
														type: type: "string"
													}
													required: [
														"type",
													]
													type: "object"
												}
												windowsOptions: {
													properties: {
														gmsaCredentialSpec: type: "string"
														gmsaCredentialSpecName: type: "string"
														hostProcess: type: "boolean"
														runAsUserName: type: "string"
													}
													type: "object"
												}
											}
											type: "object"
										}
										startupProbe: {
											properties: {
												exec: {
													properties: command: {
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													format: "int32"
													type:   "integer"
												}
												grpc: {
													properties: {
														port: {
															format: "int32"
															type:   "integer"
														}
														service: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												httpGet: {
													properties: {
														host: type: "string"
														httpHeaders: {
															items: {
																properties: {
																	name: type: "string"
																	value: type: "string"
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
														scheme: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												initialDelaySeconds: {
													format: "int32"
													type:   "integer"
												}
												periodSeconds: {
													format: "int32"
													type:   "integer"
												}
												successThreshold: {
													format: "int32"
													type:   "integer"
												}
												tcpSocket: {
													properties: {
														host: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
													}
													required: [
														"port",
													]
													type: "object"
												}
												terminationGracePeriodSeconds: {
													format: "int64"
													type:   "integer"
												}
												timeoutSeconds: {
													format: "int32"
													type:   "integer"
												}
											}
											type: "object"
										}
										stdin: type: "boolean"
										stdinOnce: type: "boolean"
										terminationMessagePath: type: "string"
										terminationMessagePolicy: type: "string"
										tty: type: "boolean"
										volumeDevices: {
											items: {
												properties: {
													devicePath: type: "string"
													name: type: "string"
												}
												required: [
													"devicePath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										volumeMounts: {
											items: {
												properties: {
													mountPath: type: "string"
													mountPropagation: type: "string"
													name: type: "string"
													readOnly: type: "boolean"
													subPath: type: "string"
													subPathExpr: type: "string"
												}
												required: [
													"mountPath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										workingDir: type: "string"
									}
									required: [
										"name",
									]
									type: "object"
								}
								type: "array"
							}
							externalUrl: type: "string"
							forceEnableClusterMode: type: "boolean"
							hostAliases: {
								items: {
									properties: {
										hostnames: {
											items: type: "string"
											type: "array"
										}
										ip: type: "string"
									}
									required: [
										"hostnames",
										"ip",
									]
									type: "object"
								}
								type: "array"
								"x-kubernetes-list-map-keys": [
									"ip",
								]
								"x-kubernetes-list-type": "map"
							}
							image: type: "string"
							imagePullPolicy: {
								enum: [
									"",
									"Always",
									"Never",
									"IfNotPresent",
								]
								type: "string"
							}
							imagePullSecrets: {
								items: {
									properties: name: type: "string"
									type:                    "object"
									"x-kubernetes-map-type": "atomic"
								}
								type: "array"
							}
							initContainers: {
								items: {
									properties: {
										args: {
											items: type: "string"
											type: "array"
										}
										command: {
											items: type: "string"
											type: "array"
										}
										env: {
											items: {
												properties: {
													name: type: "string"
													value: type: "string"
													valueFrom: {
														properties: {
															configMapKeyRef: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															fieldRef: {
																properties: {
																	apiVersion: type: "string"
																	fieldPath: type: "string"
																}
																required: [
																	"fieldPath",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															resourceFieldRef: {
																properties: {
																	containerName: type: "string"
																	divisor: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	resource: type: "string"
																}
																required: [
																	"resource",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															secretKeyRef: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
														}
														type: "object"
													}
												}
												required: [
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										envFrom: {
											items: {
												properties: {
													configMapRef: {
														properties: {
															name: type: "string"
															optional: type: "boolean"
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													prefix: type: "string"
													secretRef: {
														properties: {
															name: type: "string"
															optional: type: "boolean"
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											type: "array"
										}
										image: type: "string"
										imagePullPolicy: type: "string"
										lifecycle: {
											properties: {
												postStart: {
													properties: {
														exec: {
															properties: command: {
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														httpGet: {
															properties: {
																host: type: "string"
																httpHeaders: {
																	items: {
																		properties: {
																			name: type: "string"
																			value: type: "string"
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																path: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
																scheme: type: "string"
															}
															required: [
																"port",
															]
															type: "object"
														}
														sleep: {
															properties: seconds: {
																format: "int64"
																type:   "integer"
															}
															required: [
																"seconds",
															]
															type: "object"
														}
														tcpSocket: {
															properties: {
																host: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
															}
															required: [
																"port",
															]
															type: "object"
														}
													}
													type: "object"
												}
												preStop: {
													properties: {
														exec: {
															properties: command: {
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														httpGet: {
															properties: {
																host: type: "string"
																httpHeaders: {
																	items: {
																		properties: {
																			name: type: "string"
																			value: type: "string"
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																path: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
																scheme: type: "string"
															}
															required: [
																"port",
															]
															type: "object"
														}
														sleep: {
															properties: seconds: {
																format: "int64"
																type:   "integer"
															}
															required: [
																"seconds",
															]
															type: "object"
														}
														tcpSocket: {
															properties: {
																host: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
															}
															required: [
																"port",
															]
															type: "object"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										livenessProbe: {
											properties: {
												exec: {
													properties: command: {
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													format: "int32"
													type:   "integer"
												}
												grpc: {
													properties: {
														port: {
															format: "int32"
															type:   "integer"
														}
														service: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												httpGet: {
													properties: {
														host: type: "string"
														httpHeaders: {
															items: {
																properties: {
																	name: type: "string"
																	value: type: "string"
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
														scheme: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												initialDelaySeconds: {
													format: "int32"
													type:   "integer"
												}
												periodSeconds: {
													format: "int32"
													type:   "integer"
												}
												successThreshold: {
													format: "int32"
													type:   "integer"
												}
												tcpSocket: {
													properties: {
														host: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
													}
													required: [
														"port",
													]
													type: "object"
												}
												terminationGracePeriodSeconds: {
													format: "int64"
													type:   "integer"
												}
												timeoutSeconds: {
													format: "int32"
													type:   "integer"
												}
											}
											type: "object"
										}
										name: type: "string"
										ports: {
											items: {
												properties: {
													containerPort: {
														format: "int32"
														type:   "integer"
													}
													hostIP: type: "string"
													hostPort: {
														format: "int32"
														type:   "integer"
													}
													name: type: "string"
													protocol: {
														default: "TCP"
														type:    "string"
													}
												}
												required: [
													"containerPort",
												]
												type: "object"
											}
											type: "array"
											"x-kubernetes-list-map-keys": [
												"containerPort",
												"protocol",
											]
											"x-kubernetes-list-type": "map"
										}
										readinessProbe: {
											properties: {
												exec: {
													properties: command: {
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													format: "int32"
													type:   "integer"
												}
												grpc: {
													properties: {
														port: {
															format: "int32"
															type:   "integer"
														}
														service: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												httpGet: {
													properties: {
														host: type: "string"
														httpHeaders: {
															items: {
																properties: {
																	name: type: "string"
																	value: type: "string"
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
														scheme: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												initialDelaySeconds: {
													format: "int32"
													type:   "integer"
												}
												periodSeconds: {
													format: "int32"
													type:   "integer"
												}
												successThreshold: {
													format: "int32"
													type:   "integer"
												}
												tcpSocket: {
													properties: {
														host: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
													}
													required: [
														"port",
													]
													type: "object"
												}
												terminationGracePeriodSeconds: {
													format: "int64"
													type:   "integer"
												}
												timeoutSeconds: {
													format: "int32"
													type:   "integer"
												}
											}
											type: "object"
										}
										resizePolicy: {
											items: {
												properties: {
													resourceName: type: "string"
													restartPolicy: type: "string"
												}
												required: [
													"resourceName",
													"restartPolicy",
												]
												type: "object"
											}
											type:                     "array"
											"x-kubernetes-list-type": "atomic"
										}
										resources: {
											properties: {
												claims: {
													items: {
														properties: name: type: "string"
														required: [
															"name",
														]
														type: "object"
													}
													type: "array"
													"x-kubernetes-list-map-keys": [
														"name",
													]
													"x-kubernetes-list-type": "map"
												}
												limits: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													type: "object"
												}
												requests: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													type: "object"
												}
											}
											type: "object"
										}
										restartPolicy: type: "string"
										securityContext: {
											properties: {
												allowPrivilegeEscalation: type: "boolean"
												capabilities: {
													properties: {
														add: {
															items: type: "string"
															type: "array"
														}
														drop: {
															items: type: "string"
															type: "array"
														}
													}
													type: "object"
												}
												privileged: type: "boolean"
												procMount: type: "string"
												readOnlyRootFilesystem: type: "boolean"
												runAsGroup: {
													format: "int64"
													type:   "integer"
												}
												runAsNonRoot: type: "boolean"
												runAsUser: {
													format: "int64"
													type:   "integer"
												}
												seLinuxOptions: {
													properties: {
														level: type: "string"
														role: type: "string"
														type: type: "string"
														user: type: "string"
													}
													type: "object"
												}
												seccompProfile: {
													properties: {
														localhostProfile: type: "string"
														type: type: "string"
													}
													required: [
														"type",
													]
													type: "object"
												}
												windowsOptions: {
													properties: {
														gmsaCredentialSpec: type: "string"
														gmsaCredentialSpecName: type: "string"
														hostProcess: type: "boolean"
														runAsUserName: type: "string"
													}
													type: "object"
												}
											}
											type: "object"
										}
										startupProbe: {
											properties: {
												exec: {
													properties: command: {
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													format: "int32"
													type:   "integer"
												}
												grpc: {
													properties: {
														port: {
															format: "int32"
															type:   "integer"
														}
														service: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												httpGet: {
													properties: {
														host: type: "string"
														httpHeaders: {
															items: {
																properties: {
																	name: type: "string"
																	value: type: "string"
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
														scheme: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												initialDelaySeconds: {
													format: "int32"
													type:   "integer"
												}
												periodSeconds: {
													format: "int32"
													type:   "integer"
												}
												successThreshold: {
													format: "int32"
													type:   "integer"
												}
												tcpSocket: {
													properties: {
														host: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
													}
													required: [
														"port",
													]
													type: "object"
												}
												terminationGracePeriodSeconds: {
													format: "int64"
													type:   "integer"
												}
												timeoutSeconds: {
													format: "int32"
													type:   "integer"
												}
											}
											type: "object"
										}
										stdin: type: "boolean"
										stdinOnce: type: "boolean"
										terminationMessagePath: type: "string"
										terminationMessagePolicy: type: "string"
										tty: type: "boolean"
										volumeDevices: {
											items: {
												properties: {
													devicePath: type: "string"
													name: type: "string"
												}
												required: [
													"devicePath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										volumeMounts: {
											items: {
												properties: {
													mountPath: type: "string"
													mountPropagation: type: "string"
													name: type: "string"
													readOnly: type: "boolean"
													subPath: type: "string"
													subPathExpr: type: "string"
												}
												required: [
													"mountPath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										workingDir: type: "string"
									}
									required: [
										"name",
									]
									type: "object"
								}
								type: "array"
							}
							listenLocal: type: "boolean"
							logFormat: {
								enum: [
									"",
									"logfmt",
									"json",
								]
								type: "string"
							}
							logLevel: {
								enum: [
									"",
									"debug",
									"info",
									"warn",
									"error",
								]
								type: "string"
							}
							minReadySeconds: {
								format: "int32"
								type:   "integer"
							}
							nodeSelector: {
								additionalProperties: type: "string"
								type: "object"
							}
							paused: type: "boolean"
							podMetadata: {
								properties: {
									annotations: {
										additionalProperties: type: "string"
										type: "object"
									}
									labels: {
										additionalProperties: type: "string"
										type: "object"
									}
									name: type: "string"
								}
								type: "object"
							}
							portName: {
								default: "web"
								type:    "string"
							}
							priorityClassName: type: "string"
							replicas: {
								format: "int32"
								type:   "integer"
							}
							resources: {
								properties: {
									claims: {
										items: {
											properties: name: type: "string"
											required: [
												"name",
											]
											type: "object"
										}
										type: "array"
										"x-kubernetes-list-map-keys": [
											"name",
										]
										"x-kubernetes-list-type": "map"
									}
									limits: {
										additionalProperties: {
											anyOf: [{
												type: "integer"
											}, {
												type: "string"
											}]
											pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
											"x-kubernetes-int-or-string": true
										}
										type: "object"
									}
									requests: {
										additionalProperties: {
											anyOf: [{
												type: "integer"
											}, {
												type: "string"
											}]
											pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
											"x-kubernetes-int-or-string": true
										}
										type: "object"
									}
								}
								type: "object"
							}
							retention: {
								default: "120h"
								pattern: "^(0|(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
								type:    "string"
							}
							routePrefix: type: "string"
							secrets: {
								items: type: "string"
								type: "array"
							}
							securityContext: {
								properties: {
									fsGroup: {
										format: "int64"
										type:   "integer"
									}
									fsGroupChangePolicy: type: "string"
									runAsGroup: {
										format: "int64"
										type:   "integer"
									}
									runAsNonRoot: type: "boolean"
									runAsUser: {
										format: "int64"
										type:   "integer"
									}
									seLinuxOptions: {
										properties: {
											level: type: "string"
											role: type: "string"
											type: type: "string"
											user: type: "string"
										}
										type: "object"
									}
									seccompProfile: {
										properties: {
											localhostProfile: type: "string"
											type: type: "string"
										}
										required: [
											"type",
										]
										type: "object"
									}
									supplementalGroups: {
										items: {
											format: "int64"
											type:   "integer"
										}
										type: "array"
									}
									sysctls: {
										items: {
											properties: {
												name: type: "string"
												value: type: "string"
											}
											required: [
												"name",
												"value",
											]
											type: "object"
										}
										type: "array"
									}
									windowsOptions: {
										properties: {
											gmsaCredentialSpec: type: "string"
											gmsaCredentialSpecName: type: "string"
											hostProcess: type: "boolean"
											runAsUserName: type: "string"
										}
										type: "object"
									}
								}
								type: "object"
							}
							serviceAccountName: type: "string"
							sha: type: "string"
							storage: {
								properties: {
									disableMountSubPath: type: "boolean"
									emptyDir: {
										properties: {
											medium: type: "string"
											sizeLimit: {
												anyOf: [{
													type: "integer"
												}, {
													type: "string"
												}]
												pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
												"x-kubernetes-int-or-string": true
											}
										}
										type: "object"
									}
									ephemeral: {
										properties: volumeClaimTemplate: {
											properties: {
												metadata: type: "object"
												spec: {
													properties: {
														accessModes: {
															items: type: "string"
															type: "array"
														}
														dataSource: {
															properties: {
																apiGroup: type: "string"
																kind: type: "string"
																name: type: "string"
															}
															required: [
																"kind",
																"name",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														dataSourceRef: {
															properties: {
																apiGroup: type: "string"
																kind: type: "string"
																name: type: "string"
																namespace: type: "string"
															}
															required: [
																"kind",
																"name",
															]
															type: "object"
														}
														resources: {
															properties: {
																limits: {
																	additionalProperties: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	type: "object"
																}
																requests: {
																	additionalProperties: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	type: "object"
																}
															}
															type: "object"
														}
														selector: {
															properties: {
																matchExpressions: {
																	items: {
																		properties: {
																			key: type: "string"
																			operator: type: "string"
																			values: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														storageClassName: type: "string"
														volumeAttributesClassName: type: "string"
														volumeMode: type: "string"
														volumeName: type: "string"
													}
													type: "object"
												}
											}
											required: [
												"spec",
											]
											type: "object"
										}
										type: "object"
									}
									volumeClaimTemplate: {
										properties: {
											apiVersion: type: "string"
											kind: type: "string"
											metadata: {
												properties: {
													annotations: {
														additionalProperties: type: "string"
														type: "object"
													}
													labels: {
														additionalProperties: type: "string"
														type: "object"
													}
													name: type: "string"
												}
												type: "object"
											}
											spec: {
												properties: {
													accessModes: {
														items: type: "string"
														type: "array"
													}
													dataSource: {
														properties: {
															apiGroup: type: "string"
															kind: type: "string"
															name: type: "string"
														}
														required: [
															"kind",
															"name",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													dataSourceRef: {
														properties: {
															apiGroup: type: "string"
															kind: type: "string"
															name: type: "string"
															namespace: type: "string"
														}
														required: [
															"kind",
															"name",
														]
														type: "object"
													}
													resources: {
														properties: {
															limits: {
																additionalProperties: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																	"x-kubernetes-int-or-string": true
																}
																type: "object"
															}
															requests: {
																additionalProperties: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																	"x-kubernetes-int-or-string": true
																}
																type: "object"
															}
														}
														type: "object"
													}
													selector: {
														properties: {
															matchExpressions: {
																items: {
																	properties: {
																		key: type: "string"
																		operator: type: "string"
																		values: {
																			items: type: "string"
																			type: "array"
																		}
																	}
																	required: [
																		"key",
																		"operator",
																	]
																	type: "object"
																}
																type: "array"
															}
															matchLabels: {
																additionalProperties: type: "string"
																type: "object"
															}
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													storageClassName: type: "string"
													volumeAttributesClassName: type: "string"
													volumeMode: type: "string"
													volumeName: type: "string"
												}
												type: "object"
											}
											status: {
												properties: {
													accessModes: {
														items: type: "string"
														type: "array"
													}
													allocatedResourceStatuses: {
														additionalProperties: type: "string"
														type:                    "object"
														"x-kubernetes-map-type": "granular"
													}
													allocatedResources: {
														additionalProperties: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
															"x-kubernetes-int-or-string": true
														}
														type: "object"
													}
													capacity: {
														additionalProperties: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
															"x-kubernetes-int-or-string": true
														}
														type: "object"
													}
													conditions: {
														items: {
															properties: {
																lastProbeTime: {
																	format: "date-time"
																	type:   "string"
																}
																lastTransitionTime: {
																	format: "date-time"
																	type:   "string"
																}
																message: type: "string"
																reason: type: "string"
																status: type: "string"
																type: type: "string"
															}
															required: [
																"status",
																"type",
															]
															type: "object"
														}
														type: "array"
													}
													currentVolumeAttributesClassName: type: "string"
													modifyVolumeStatus: {
														properties: {
															status: type: "string"
															targetVolumeAttributesClassName: type: "string"
														}
														required: [
															"status",
														]
														type: "object"
													}
													phase: type: "string"
												}
												type: "object"
											}
										}
										type: "object"
									}
								}
								type: "object"
							}
							tag: type: "string"
							tolerations: {
								items: {
									properties: {
										effect: type: "string"
										key: type: "string"
										operator: type: "string"
										tolerationSeconds: {
											format: "int64"
											type:   "integer"
										}
										value: type: "string"
									}
									type: "object"
								}
								type: "array"
							}
							topologySpreadConstraints: {
								items: {
									properties: {
										labelSelector: {
											properties: {
												matchExpressions: {
													items: {
														properties: {
															key: type: "string"
															operator: type: "string"
															values: {
																items: type: "string"
																type: "array"
															}
														}
														required: [
															"key",
															"operator",
														]
														type: "object"
													}
													type: "array"
												}
												matchLabels: {
													additionalProperties: type: "string"
													type: "object"
												}
											}
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										matchLabelKeys: {
											items: type: "string"
											type:                     "array"
											"x-kubernetes-list-type": "atomic"
										}
										maxSkew: {
											format: "int32"
											type:   "integer"
										}
										minDomains: {
											format: "int32"
											type:   "integer"
										}
										nodeAffinityPolicy: type: "string"
										nodeTaintsPolicy: type: "string"
										topologyKey: type: "string"
										whenUnsatisfiable: type: "string"
									}
									required: [
										"maxSkew",
										"topologyKey",
										"whenUnsatisfiable",
									]
									type: "object"
								}
								type: "array"
							}
							version: type: "string"
							volumeMounts: {
								items: {
									properties: {
										mountPath: type: "string"
										mountPropagation: type: "string"
										name: type: "string"
										readOnly: type: "boolean"
										subPath: type: "string"
										subPathExpr: type: "string"
									}
									required: [
										"mountPath",
										"name",
									]
									type: "object"
								}
								type: "array"
							}
							volumes: {
								items: {
									properties: {
										awsElasticBlockStore: {
											properties: {
												fsType: type: "string"
												partition: {
													format: "int32"
													type:   "integer"
												}
												readOnly: type: "boolean"
												volumeID: type: "string"
											}
											required: [
												"volumeID",
											]
											type: "object"
										}
										azureDisk: {
											properties: {
												cachingMode: type: "string"
												diskName: type: "string"
												diskURI: type: "string"
												fsType: type: "string"
												kind: type: "string"
												readOnly: type: "boolean"
											}
											required: [
												"diskName",
												"diskURI",
											]
											type: "object"
										}
										azureFile: {
											properties: {
												readOnly: type: "boolean"
												secretName: type: "string"
												shareName: type: "string"
											}
											required: [
												"secretName",
												"shareName",
											]
											type: "object"
										}
										cephfs: {
											properties: {
												monitors: {
													items: type: "string"
													type: "array"
												}
												path: type: "string"
												readOnly: type: "boolean"
												secretFile: type: "string"
												secretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												user: type: "string"
											}
											required: [
												"monitors",
											]
											type: "object"
										}
										cinder: {
											properties: {
												fsType: type: "string"
												readOnly: type: "boolean"
												secretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												volumeID: type: "string"
											}
											required: [
												"volumeID",
											]
											type: "object"
										}
										configMap: {
											properties: {
												defaultMode: {
													format: "int32"
													type:   "integer"
												}
												items: {
													items: {
														properties: {
															key: type: "string"
															mode: {
																format: "int32"
																type:   "integer"
															}
															path: type: "string"
														}
														required: [
															"key",
															"path",
														]
														type: "object"
													}
													type: "array"
												}
												name: type: "string"
												optional: type: "boolean"
											}
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										csi: {
											properties: {
												driver: type: "string"
												fsType: type: "string"
												nodePublishSecretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												readOnly: type: "boolean"
												volumeAttributes: {
													additionalProperties: type: "string"
													type: "object"
												}
											}
											required: [
												"driver",
											]
											type: "object"
										}
										downwardAPI: {
											properties: {
												defaultMode: {
													format: "int32"
													type:   "integer"
												}
												items: {
													items: {
														properties: {
															fieldRef: {
																properties: {
																	apiVersion: type: "string"
																	fieldPath: type: "string"
																}
																required: [
																	"fieldPath",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															mode: {
																format: "int32"
																type:   "integer"
															}
															path: type: "string"
															resourceFieldRef: {
																properties: {
																	containerName: type: "string"
																	divisor: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	resource: type: "string"
																}
																required: [
																	"resource",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
														}
														required: [
															"path",
														]
														type: "object"
													}
													type: "array"
												}
											}
											type: "object"
										}
										emptyDir: {
											properties: {
												medium: type: "string"
												sizeLimit: {
													anyOf: [{
														type: "integer"
													}, {
														type: "string"
													}]
													pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
													"x-kubernetes-int-or-string": true
												}
											}
											type: "object"
										}
										ephemeral: {
											properties: volumeClaimTemplate: {
												properties: {
													metadata: type: "object"
													spec: {
														properties: {
															accessModes: {
																items: type: "string"
																type: "array"
															}
															dataSource: {
																properties: {
																	apiGroup: type: "string"
																	kind: type: "string"
																	name: type: "string"
																}
																required: [
																	"kind",
																	"name",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															dataSourceRef: {
																properties: {
																	apiGroup: type: "string"
																	kind: type: "string"
																	name: type: "string"
																	namespace: type: "string"
																}
																required: [
																	"kind",
																	"name",
																]
																type: "object"
															}
															resources: {
																properties: {
																	limits: {
																		additionalProperties: {
																			anyOf: [{
																				type: "integer"
																			}, {
																				type: "string"
																			}]
																			pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																			"x-kubernetes-int-or-string": true
																		}
																		type: "object"
																	}
																	requests: {
																		additionalProperties: {
																			anyOf: [{
																				type: "integer"
																			}, {
																				type: "string"
																			}]
																			pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																			"x-kubernetes-int-or-string": true
																		}
																		type: "object"
																	}
																}
																type: "object"
															}
															selector: {
																properties: {
																	matchExpressions: {
																		items: {
																			properties: {
																				key: type: "string"
																				operator: type: "string"
																				values: {
																					items: type: "string"
																					type: "array"
																				}
																			}
																			required: [
																				"key",
																				"operator",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	matchLabels: {
																		additionalProperties: type: "string"
																		type: "object"
																	}
																}
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															storageClassName: type: "string"
															volumeAttributesClassName: type: "string"
															volumeMode: type: "string"
															volumeName: type: "string"
														}
														type: "object"
													}
												}
												required: [
													"spec",
												]
												type: "object"
											}
											type: "object"
										}
										fc: {
											properties: {
												fsType: type: "string"
												lun: {
													format: "int32"
													type:   "integer"
												}
												readOnly: type: "boolean"
												targetWWNs: {
													items: type: "string"
													type: "array"
												}
												wwids: {
													items: type: "string"
													type: "array"
												}
											}
											type: "object"
										}
										flexVolume: {
											properties: {
												driver: type: "string"
												fsType: type: "string"
												options: {
													additionalProperties: type: "string"
													type: "object"
												}
												readOnly: type: "boolean"
												secretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
											}
											required: [
												"driver",
											]
											type: "object"
										}
										flocker: {
											properties: {
												datasetName: type: "string"
												datasetUUID: type: "string"
											}
											type: "object"
										}
										gcePersistentDisk: {
											properties: {
												fsType: type: "string"
												partition: {
													format: "int32"
													type:   "integer"
												}
												pdName: type: "string"
												readOnly: type: "boolean"
											}
											required: [
												"pdName",
											]
											type: "object"
										}
										gitRepo: {
											properties: {
												directory: type: "string"
												repository: type: "string"
												revision: type: "string"
											}
											required: [
												"repository",
											]
											type: "object"
										}
										glusterfs: {
											properties: {
												endpoints: type: "string"
												path: type: "string"
												readOnly: type: "boolean"
											}
											required: [
												"endpoints",
												"path",
											]
											type: "object"
										}
										hostPath: {
											properties: {
												path: type: "string"
												type: type: "string"
											}
											required: [
												"path",
											]
											type: "object"
										}
										iscsi: {
											properties: {
												chapAuthDiscovery: type: "boolean"
												chapAuthSession: type: "boolean"
												fsType: type: "string"
												initiatorName: type: "string"
												iqn: type: "string"
												iscsiInterface: type: "string"
												lun: {
													format: "int32"
													type:   "integer"
												}
												portals: {
													items: type: "string"
													type: "array"
												}
												readOnly: type: "boolean"
												secretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												targetPortal: type: "string"
											}
											required: [
												"iqn",
												"lun",
												"targetPortal",
											]
											type: "object"
										}
										name: type: "string"
										nfs: {
											properties: {
												path: type: "string"
												readOnly: type: "boolean"
												server: type: "string"
											}
											required: [
												"path",
												"server",
											]
											type: "object"
										}
										persistentVolumeClaim: {
											properties: {
												claimName: type: "string"
												readOnly: type: "boolean"
											}
											required: [
												"claimName",
											]
											type: "object"
										}
										photonPersistentDisk: {
											properties: {
												fsType: type: "string"
												pdID: type: "string"
											}
											required: [
												"pdID",
											]
											type: "object"
										}
										portworxVolume: {
											properties: {
												fsType: type: "string"
												readOnly: type: "boolean"
												volumeID: type: "string"
											}
											required: [
												"volumeID",
											]
											type: "object"
										}
										projected: {
											properties: {
												defaultMode: {
													format: "int32"
													type:   "integer"
												}
												sources: {
													items: {
														properties: {
															clusterTrustBundle: {
																properties: {
																	labelSelector: {
																		properties: {
																			matchExpressions: {
																				items: {
																					properties: {
																						key: type: "string"
																						operator: type: "string"
																						values: {
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			matchLabels: {
																				additionalProperties: type: "string"
																				type: "object"
																			}
																		}
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	name: type: "string"
																	optional: type: "boolean"
																	path: type: "string"
																	signerName: type: "string"
																}
																required: [
																	"path",
																]
																type: "object"
															}
															configMap: {
																properties: {
																	items: {
																		items: {
																			properties: {
																				key: type: "string"
																				mode: {
																					format: "int32"
																					type:   "integer"
																				}
																				path: type: "string"
																			}
																			required: [
																				"key",
																				"path",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	name: type: "string"
																	optional: type: "boolean"
																}
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															downwardAPI: {
																properties: items: {
																	items: {
																		properties: {
																			fieldRef: {
																				properties: {
																					apiVersion: type: "string"
																					fieldPath: type: "string"
																				}
																				required: [
																					"fieldPath",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			mode: {
																				format: "int32"
																				type:   "integer"
																			}
																			path: type: "string"
																			resourceFieldRef: {
																				properties: {
																					containerName: type: "string"
																					divisor: {
																						anyOf: [{
																							type: "integer"
																						}, {
																							type: "string"
																						}]
																						pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																						"x-kubernetes-int-or-string": true
																					}
																					resource: type: "string"
																				}
																				required: [
																					"resource",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		required: [
																			"path",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																type: "object"
															}
															secret: {
																properties: {
																	items: {
																		items: {
																			properties: {
																				key: type: "string"
																				mode: {
																					format: "int32"
																					type:   "integer"
																				}
																				path: type: "string"
																			}
																			required: [
																				"key",
																				"path",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	name: type: "string"
																	optional: type: "boolean"
																}
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															serviceAccountToken: {
																properties: {
																	audience: type: "string"
																	expirationSeconds: {
																		format: "int64"
																		type:   "integer"
																	}
																	path: type: "string"
																}
																required: [
																	"path",
																]
																type: "object"
															}
														}
														type: "object"
													}
													type: "array"
												}
											}
											type: "object"
										}
										quobyte: {
											properties: {
												group: type: "string"
												readOnly: type: "boolean"
												registry: type: "string"
												tenant: type: "string"
												user: type: "string"
												volume: type: "string"
											}
											required: [
												"registry",
												"volume",
											]
											type: "object"
										}
										rbd: {
											properties: {
												fsType: type: "string"
												image: type: "string"
												keyring: type: "string"
												monitors: {
													items: type: "string"
													type: "array"
												}
												pool: type: "string"
												readOnly: type: "boolean"
												secretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												user: type: "string"
											}
											required: [
												"image",
												"monitors",
											]
											type: "object"
										}
										scaleIO: {
											properties: {
												fsType: type: "string"
												gateway: type: "string"
												protectionDomain: type: "string"
												readOnly: type: "boolean"
												secretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												sslEnabled: type: "boolean"
												storageMode: type: "string"
												storagePool: type: "string"
												system: type: "string"
												volumeName: type: "string"
											}
											required: [
												"gateway",
												"secretRef",
												"system",
											]
											type: "object"
										}
										secret: {
											properties: {
												defaultMode: {
													format: "int32"
													type:   "integer"
												}
												items: {
													items: {
														properties: {
															key: type: "string"
															mode: {
																format: "int32"
																type:   "integer"
															}
															path: type: "string"
														}
														required: [
															"key",
															"path",
														]
														type: "object"
													}
													type: "array"
												}
												optional: type: "boolean"
												secretName: type: "string"
											}
											type: "object"
										}
										storageos: {
											properties: {
												fsType: type: "string"
												readOnly: type: "boolean"
												secretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												volumeName: type: "string"
												volumeNamespace: type: "string"
											}
											type: "object"
										}
										vsphereVolume: {
											properties: {
												fsType: type: "string"
												storagePolicyID: type: "string"
												storagePolicyName: type: "string"
												volumePath: type: "string"
											}
											required: [
												"volumePath",
											]
											type: "object"
										}
									}
									required: [
										"name",
									]
									type: "object"
								}
								type: "array"
							}
							web: {
								properties: {
									getConcurrency: {
										format: "int32"
										type:   "integer"
									}
									httpConfig: {
										properties: {
											headers: {
												properties: {
													contentSecurityPolicy: type: "string"
													strictTransportSecurity: type: "string"
													xContentTypeOptions: {
														enum: [
															"",
															"NoSniff",
														]
														type: "string"
													}
													xFrameOptions: {
														enum: [
															"",
															"Deny",
															"SameOrigin",
														]
														type: "string"
													}
													xXSSProtection: type: "string"
												}
												type: "object"
											}
											http2: type: "boolean"
										}
										type: "object"
									}
									timeout: {
										format: "int32"
										type:   "integer"
									}
									tlsConfig: {
										properties: {
											cert: {
												properties: {
													configMap: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													secret: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											cipherSuites: {
												items: type: "string"
												type: "array"
											}
											client_ca: {
												properties: {
													configMap: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													secret: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											clientAuthType: type: "string"
											curvePreferences: {
												items: type: "string"
												type: "array"
											}
											keySecret: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											maxVersion: type: "string"
											minVersion: type: "string"
											preferServerCipherSuites: type: "boolean"
										}
										required: [
											"cert",
											"keySecret",
										]
										type: "object"
									}
								}
								type: "object"
							}
						}
						type: "object"
					}
					status: {
						properties: {
							availableReplicas: {
								format: "int32"
								type:   "integer"
							}
							conditions: {
								items: {
									properties: {
										lastTransitionTime: {
											format: "date-time"
											type:   "string"
										}
										message: type: "string"
										observedGeneration: {
											format: "int64"
											type:   "integer"
										}
										reason: type: "string"
										status: type: "string"
										type: type: "string"
									}
									required: [
										"lastTransitionTime",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
								"x-kubernetes-list-map-keys": [
									"type",
								]
								"x-kubernetes-list-type": "map"
							}
							paused: type: "boolean"
							replicas: {
								format: "int32"
								type:   "integer"
							}
							unavailableReplicas: {
								format: "int32"
								type:   "integer"
							}
							updatedReplicas: {
								format: "int32"
								type:   "integer"
							}
						}
						required: [
							"availableReplicas",
							"paused",
							"replicas",
							"unavailableReplicas",
							"updatedReplicas",
						]
						type: "object"
					}
				}
				required: [
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}, {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: {
			"controller-gen.kubebuilder.io/version": "v0.13.0"
			"operator.prometheus.io/version":        "0.72.0"
		}
		name: "podmonitors.monitoring.coreos.com"
	}
	spec: {
		group: "monitoring.coreos.com"
		names: {
			categories: [
				"prometheus-operator",
			]
			kind:     "PodMonitor"
			listKind: "PodMonitorList"
			plural:   "podmonitors"
			shortNames: [
				"pmon",
			]
			singular: "podmonitor"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				properties: {
					apiVersion: type: "string"
					kind: type: "string"
					metadata: type: "object"
					spec: {
						properties: {
							attachMetadata: {
								properties: node: type: "boolean"
								type: "object"
							}
							jobLabel: type: "string"
							keepDroppedTargets: {
								format: "int64"
								type:   "integer"
							}
							labelLimit: {
								format: "int64"
								type:   "integer"
							}
							labelNameLengthLimit: {
								format: "int64"
								type:   "integer"
							}
							labelValueLengthLimit: {
								format: "int64"
								type:   "integer"
							}
							namespaceSelector: {
								properties: {
									any: type: "boolean"
									matchNames: {
										items: type: "string"
										type: "array"
									}
								}
								type: "object"
							}
							podMetricsEndpoints: {
								items: {
									properties: {
										authorization: {
											properties: {
												credentials: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												type: type: "string"
											}
											type: "object"
										}
										basicAuth: {
											properties: {
												password: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												username: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
											}
											type: "object"
										}
										bearerTokenSecret: {
											properties: {
												key: type: "string"
												name: type: "string"
												optional: type: "boolean"
											}
											required: [
												"key",
											]
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										enableHttp2: type: "boolean"
										filterRunning: type: "boolean"
										followRedirects: type: "boolean"
										honorLabels: type: "boolean"
										honorTimestamps: type: "boolean"
										interval: {
											pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
											type:    "string"
										}
										metricRelabelings: {
											items: {
												properties: {
													action: {
														default: "replace"
														enum: [
															"replace",
															"Replace",
															"keep",
															"Keep",
															"drop",
															"Drop",
															"hashmod",
															"HashMod",
															"labelmap",
															"LabelMap",
															"labeldrop",
															"LabelDrop",
															"labelkeep",
															"LabelKeep",
															"lowercase",
															"Lowercase",
															"uppercase",
															"Uppercase",
															"keepequal",
															"KeepEqual",
															"dropequal",
															"DropEqual",
														]
														type: "string"
													}
													modulus: {
														format: "int64"
														type:   "integer"
													}
													regex: type: "string"
													replacement: type: "string"
													separator: type: "string"
													sourceLabels: {
														items: {
															pattern: "^[a-zA-Z_][a-zA-Z0-9_]*$"
															type:    "string"
														}
														type: "array"
													}
													targetLabel: type: "string"
												}
												type: "object"
											}
											type: "array"
										}
										oauth2: {
											properties: {
												clientId: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												clientSecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												endpointParams: {
													additionalProperties: type: "string"
													type: "object"
												}
												scopes: {
													items: type: "string"
													type: "array"
												}
												tokenUrl: {
													minLength: 1
													type:      "string"
												}
											}
											required: [
												"clientId",
												"clientSecret",
												"tokenUrl",
											]
											type: "object"
										}
										params: {
											additionalProperties: {
												items: type: "string"
												type: "array"
											}
											type: "object"
										}
										path: type: "string"
										port: type: "string"
										proxyUrl: type: "string"
										relabelings: {
											items: {
												properties: {
													action: {
														default: "replace"
														enum: [
															"replace",
															"Replace",
															"keep",
															"Keep",
															"drop",
															"Drop",
															"hashmod",
															"HashMod",
															"labelmap",
															"LabelMap",
															"labeldrop",
															"LabelDrop",
															"labelkeep",
															"LabelKeep",
															"lowercase",
															"Lowercase",
															"uppercase",
															"Uppercase",
															"keepequal",
															"KeepEqual",
															"dropequal",
															"DropEqual",
														]
														type: "string"
													}
													modulus: {
														format: "int64"
														type:   "integer"
													}
													regex: type: "string"
													replacement: type: "string"
													separator: type: "string"
													sourceLabels: {
														items: {
															pattern: "^[a-zA-Z_][a-zA-Z0-9_]*$"
															type:    "string"
														}
														type: "array"
													}
													targetLabel: type: "string"
												}
												type: "object"
											}
											type: "array"
										}
										scheme: {
											enum: [
												"http",
												"https",
											]
											type: "string"
										}
										scrapeTimeout: {
											pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
											type:    "string"
										}
										targetPort: {
											anyOf: [{
												type: "integer"
											}, {
												type: "string"
											}]
											"x-kubernetes-int-or-string": true
										}
										tlsConfig: {
											properties: {
												ca: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												cert: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												insecureSkipVerify: type: "boolean"
												keySecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												serverName: type: "string"
											}
											type: "object"
										}
										trackTimestampsStaleness: type: "boolean"
									}
									type: "object"
								}
								type: "array"
							}
							podTargetLabels: {
								items: type: "string"
								type: "array"
							}
							sampleLimit: {
								format: "int64"
								type:   "integer"
							}
							scrapeClass: {
								minLength: 1
								type:      "string"
							}
							scrapeProtocols: {
								items: {
									enum: [
										"PrometheusProto",
										"OpenMetricsText0.0.1",
										"OpenMetricsText1.0.0",
										"PrometheusText0.0.4",
									]
									type: "string"
								}
								type:                     "array"
								"x-kubernetes-list-type": "set"
							}
							selector: {
								properties: {
									matchExpressions: {
										items: {
											properties: {
												key: type: "string"
												operator: type: "string"
												values: {
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							targetLimit: {
								format: "int64"
								type:   "integer"
							}
						}
						required: [
							"selector",
						]
						type: "object"
					}
				}
				required: [
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
		}]
	}
}, {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: {
			"controller-gen.kubebuilder.io/version": "v0.13.0"
			"operator.prometheus.io/version":        "0.72.0"
		}
		name: "probes.monitoring.coreos.com"
	}
	spec: {
		group: "monitoring.coreos.com"
		names: {
			categories: [
				"prometheus-operator",
			]
			kind:     "Probe"
			listKind: "ProbeList"
			plural:   "probes"
			shortNames: [
				"prb",
			]
			singular: "probe"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				properties: {
					apiVersion: type: "string"
					kind: type: "string"
					metadata: type: "object"
					spec: {
						properties: {
							authorization: {
								properties: {
									credentials: {
										properties: {
											key: type: "string"
											name: type: "string"
											optional: type: "boolean"
										}
										required: [
											"key",
										]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
									type: type: "string"
								}
								type: "object"
							}
							basicAuth: {
								properties: {
									password: {
										properties: {
											key: type: "string"
											name: type: "string"
											optional: type: "boolean"
										}
										required: [
											"key",
										]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
									username: {
										properties: {
											key: type: "string"
											name: type: "string"
											optional: type: "boolean"
										}
										required: [
											"key",
										]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
								}
								type: "object"
							}
							bearerTokenSecret: {
								properties: {
									key: type: "string"
									name: type: "string"
									optional: type: "boolean"
								}
								required: [
									"key",
								]
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							interval: {
								pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
								type:    "string"
							}
							jobName: type: "string"
							keepDroppedTargets: {
								format: "int64"
								type:   "integer"
							}
							labelLimit: {
								format: "int64"
								type:   "integer"
							}
							labelNameLengthLimit: {
								format: "int64"
								type:   "integer"
							}
							labelValueLengthLimit: {
								format: "int64"
								type:   "integer"
							}
							metricRelabelings: {
								items: {
									properties: {
										action: {
											default: "replace"
											enum: [
												"replace",
												"Replace",
												"keep",
												"Keep",
												"drop",
												"Drop",
												"hashmod",
												"HashMod",
												"labelmap",
												"LabelMap",
												"labeldrop",
												"LabelDrop",
												"labelkeep",
												"LabelKeep",
												"lowercase",
												"Lowercase",
												"uppercase",
												"Uppercase",
												"keepequal",
												"KeepEqual",
												"dropequal",
												"DropEqual",
											]
											type: "string"
										}
										modulus: {
											format: "int64"
											type:   "integer"
										}
										regex: type: "string"
										replacement: type: "string"
										separator: type: "string"
										sourceLabels: {
											items: {
												pattern: "^[a-zA-Z_][a-zA-Z0-9_]*$"
												type:    "string"
											}
											type: "array"
										}
										targetLabel: type: "string"
									}
									type: "object"
								}
								type: "array"
							}
							module: type: "string"
							oauth2: {
								properties: {
									clientId: {
										properties: {
											configMap: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											secret: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
										}
										type: "object"
									}
									clientSecret: {
										properties: {
											key: type: "string"
											name: type: "string"
											optional: type: "boolean"
										}
										required: [
											"key",
										]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
									endpointParams: {
										additionalProperties: type: "string"
										type: "object"
									}
									scopes: {
										items: type: "string"
										type: "array"
									}
									tokenUrl: {
										minLength: 1
										type:      "string"
									}
								}
								required: [
									"clientId",
									"clientSecret",
									"tokenUrl",
								]
								type: "object"
							}
							prober: {
								properties: {
									path: {
										default: "/probe"
										type:    "string"
									}
									proxyUrl: type: "string"
									scheme: {
										enum: [
											"http",
											"https",
										]
										type: "string"
									}
									url: type: "string"
								}
								required: [
									"url",
								]
								type: "object"
							}
							sampleLimit: {
								format: "int64"
								type:   "integer"
							}
							scrapeClass: {
								minLength: 1
								type:      "string"
							}
							scrapeProtocols: {
								items: {
									enum: [
										"PrometheusProto",
										"OpenMetricsText0.0.1",
										"OpenMetricsText1.0.0",
										"PrometheusText0.0.4",
									]
									type: "string"
								}
								type:                     "array"
								"x-kubernetes-list-type": "set"
							}
							scrapeTimeout: {
								pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
								type:    "string"
							}
							targetLimit: {
								format: "int64"
								type:   "integer"
							}
							targets: {
								properties: {
									ingress: {
										properties: {
											namespaceSelector: {
												properties: {
													any: type: "boolean"
													matchNames: {
														items: type: "string"
														type: "array"
													}
												}
												type: "object"
											}
											relabelingConfigs: {
												items: {
													properties: {
														action: {
															default: "replace"
															enum: [
																"replace",
																"Replace",
																"keep",
																"Keep",
																"drop",
																"Drop",
																"hashmod",
																"HashMod",
																"labelmap",
																"LabelMap",
																"labeldrop",
																"LabelDrop",
																"labelkeep",
																"LabelKeep",
																"lowercase",
																"Lowercase",
																"uppercase",
																"Uppercase",
																"keepequal",
																"KeepEqual",
																"dropequal",
																"DropEqual",
															]
															type: "string"
														}
														modulus: {
															format: "int64"
															type:   "integer"
														}
														regex: type: "string"
														replacement: type: "string"
														separator: type: "string"
														sourceLabels: {
															items: {
																pattern: "^[a-zA-Z_][a-zA-Z0-9_]*$"
																type:    "string"
															}
															type: "array"
														}
														targetLabel: type: "string"
													}
													type: "object"
												}
												type: "array"
											}
											selector: {
												properties: {
													matchExpressions: {
														items: {
															properties: {
																key: type: "string"
																operator: type: "string"
																values: {
																	items: type: "string"
																	type: "array"
																}
															}
															required: [
																"key",
																"operator",
															]
															type: "object"
														}
														type: "array"
													}
													matchLabels: {
														additionalProperties: type: "string"
														type: "object"
													}
												}
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
										}
										type: "object"
									}
									staticConfig: {
										properties: {
											labels: {
												additionalProperties: type: "string"
												type: "object"
											}
											relabelingConfigs: {
												items: {
													properties: {
														action: {
															default: "replace"
															enum: [
																"replace",
																"Replace",
																"keep",
																"Keep",
																"drop",
																"Drop",
																"hashmod",
																"HashMod",
																"labelmap",
																"LabelMap",
																"labeldrop",
																"LabelDrop",
																"labelkeep",
																"LabelKeep",
																"lowercase",
																"Lowercase",
																"uppercase",
																"Uppercase",
																"keepequal",
																"KeepEqual",
																"dropequal",
																"DropEqual",
															]
															type: "string"
														}
														modulus: {
															format: "int64"
															type:   "integer"
														}
														regex: type: "string"
														replacement: type: "string"
														separator: type: "string"
														sourceLabels: {
															items: {
																pattern: "^[a-zA-Z_][a-zA-Z0-9_]*$"
																type:    "string"
															}
															type: "array"
														}
														targetLabel: type: "string"
													}
													type: "object"
												}
												type: "array"
											}
											static: {
												items: type: "string"
												type: "array"
											}
										}
										type: "object"
									}
								}
								type: "object"
							}
							tlsConfig: {
								properties: {
									ca: {
										properties: {
											configMap: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											secret: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
										}
										type: "object"
									}
									cert: {
										properties: {
											configMap: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											secret: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
										}
										type: "object"
									}
									insecureSkipVerify: type: "boolean"
									keySecret: {
										properties: {
											key: type: "string"
											name: type: "string"
											optional: type: "boolean"
										}
										required: [
											"key",
										]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
									serverName: type: "string"
								}
								type: "object"
							}
						}
						type: "object"
					}
				}
				required: [
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
		}]
	}
}, {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: {
			"controller-gen.kubebuilder.io/version": "v0.13.0"
			"operator.prometheus.io/version":        "0.72.0"
		}
		name: "prometheusagents.monitoring.coreos.com"
	}
	spec: {
		group: "monitoring.coreos.com"
		names: {
			categories: [
				"prometheus-operator",
			]
			kind:     "PrometheusAgent"
			listKind: "PrometheusAgentList"
			plural:   "prometheusagents"
			shortNames: [
				"promagent",
			]
			singular: "prometheusagent"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".spec.version"
				name:     "Version"
				type:     "string"
			}, {
				jsonPath: ".spec.replicas"
				name:     "Desired"
				type:     "integer"
			}, {
				jsonPath: ".status.availableReplicas"
				name:     "Ready"
				type:     "integer"
			}, {
				jsonPath: ".status.conditions[?(@.type == 'Reconciled')].status"
				name:     "Reconciled"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type == 'Available')].status"
				name:     "Available"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}, {
				jsonPath: ".status.paused"
				name:     "Paused"
				priority: 1
				type:     "boolean"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				properties: {
					apiVersion: type: "string"
					kind: type: "string"
					metadata: type: "object"
					spec: {
						properties: {
							additionalArgs: {
								items: {
									properties: {
										name: {
											minLength: 1
											type:      "string"
										}
										value: type: "string"
									}
									required: [
										"name",
									]
									type: "object"
								}
								type: "array"
							}
							additionalScrapeConfigs: {
								properties: {
									key: type: "string"
									name: type: "string"
									optional: type: "boolean"
								}
								required: [
									"key",
								]
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							affinity: {
								properties: {
									nodeAffinity: {
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												items: {
													properties: {
														preference: {
															properties: {
																matchExpressions: {
																	items: {
																		properties: {
																			key: type: "string"
																			operator: type: "string"
																			values: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchFields: {
																	items: {
																		properties: {
																			key: type: "string"
																			operator: type: "string"
																			values: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														weight: {
															format: "int32"
															type:   "integer"
														}
													}
													required: [
														"preference",
														"weight",
													]
													type: "object"
												}
												type: "array"
											}
											requiredDuringSchedulingIgnoredDuringExecution: {
												properties: nodeSelectorTerms: {
													items: {
														properties: {
															matchExpressions: {
																items: {
																	properties: {
																		key: type: "string"
																		operator: type: "string"
																		values: {
																			items: type: "string"
																			type: "array"
																		}
																	}
																	required: [
																		"key",
																		"operator",
																	]
																	type: "object"
																}
																type: "array"
															}
															matchFields: {
																items: {
																	properties: {
																		key: type: "string"
																		operator: type: "string"
																		values: {
																			items: type: "string"
																			type: "array"
																		}
																	}
																	required: [
																		"key",
																		"operator",
																	]
																	type: "object"
																}
																type: "array"
															}
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													type: "array"
												}
												required: [
													"nodeSelectorTerms",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
										}
										type: "object"
									}
									podAffinity: {
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												items: {
													properties: {
														podAffinityTerm: {
															properties: {
																labelSelector: {
																	properties: {
																		matchExpressions: {
																			items: {
																				properties: {
																					key: type: "string"
																					operator: type: "string"
																					values: {
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchLabels: {
																			additionalProperties: type: "string"
																			type: "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																matchLabelKeys: {
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																mismatchLabelKeys: {
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																namespaceSelector: {
																	properties: {
																		matchExpressions: {
																			items: {
																				properties: {
																					key: type: "string"
																					operator: type: "string"
																					values: {
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchLabels: {
																			additionalProperties: type: "string"
																			type: "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																namespaces: {
																	items: type: "string"
																	type: "array"
																}
																topologyKey: type: "string"
															}
															required: [
																"topologyKey",
															]
															type: "object"
														}
														weight: {
															format: "int32"
															type:   "integer"
														}
													}
													required: [
														"podAffinityTerm",
														"weight",
													]
													type: "object"
												}
												type: "array"
											}
											requiredDuringSchedulingIgnoredDuringExecution: {
												items: {
													properties: {
														labelSelector: {
															properties: {
																matchExpressions: {
																	items: {
																		properties: {
																			key: type: "string"
																			operator: type: "string"
																			values: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														matchLabelKeys: {
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														mismatchLabelKeys: {
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														namespaceSelector: {
															properties: {
																matchExpressions: {
																	items: {
																		properties: {
																			key: type: "string"
																			operator: type: "string"
																			values: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														namespaces: {
															items: type: "string"
															type: "array"
														}
														topologyKey: type: "string"
													}
													required: [
														"topologyKey",
													]
													type: "object"
												}
												type: "array"
											}
										}
										type: "object"
									}
									podAntiAffinity: {
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												items: {
													properties: {
														podAffinityTerm: {
															properties: {
																labelSelector: {
																	properties: {
																		matchExpressions: {
																			items: {
																				properties: {
																					key: type: "string"
																					operator: type: "string"
																					values: {
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchLabels: {
																			additionalProperties: type: "string"
																			type: "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																matchLabelKeys: {
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																mismatchLabelKeys: {
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																namespaceSelector: {
																	properties: {
																		matchExpressions: {
																			items: {
																				properties: {
																					key: type: "string"
																					operator: type: "string"
																					values: {
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchLabels: {
																			additionalProperties: type: "string"
																			type: "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																namespaces: {
																	items: type: "string"
																	type: "array"
																}
																topologyKey: type: "string"
															}
															required: [
																"topologyKey",
															]
															type: "object"
														}
														weight: {
															format: "int32"
															type:   "integer"
														}
													}
													required: [
														"podAffinityTerm",
														"weight",
													]
													type: "object"
												}
												type: "array"
											}
											requiredDuringSchedulingIgnoredDuringExecution: {
												items: {
													properties: {
														labelSelector: {
															properties: {
																matchExpressions: {
																	items: {
																		properties: {
																			key: type: "string"
																			operator: type: "string"
																			values: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														matchLabelKeys: {
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														mismatchLabelKeys: {
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														namespaceSelector: {
															properties: {
																matchExpressions: {
																	items: {
																		properties: {
																			key: type: "string"
																			operator: type: "string"
																			values: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														namespaces: {
															items: type: "string"
															type: "array"
														}
														topologyKey: type: "string"
													}
													required: [
														"topologyKey",
													]
													type: "object"
												}
												type: "array"
											}
										}
										type: "object"
									}
								}
								type: "object"
							}
							apiserverConfig: {
								properties: {
									authorization: {
										properties: {
											credentials: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											credentialsFile: type: "string"
											type: type: "string"
										}
										type: "object"
									}
									basicAuth: {
										properties: {
											password: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											username: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
										}
										type: "object"
									}
									bearerToken: type: "string"
									bearerTokenFile: type: "string"
									host: type: "string"
									tlsConfig: {
										properties: {
											ca: {
												properties: {
													configMap: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													secret: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											caFile: type: "string"
											cert: {
												properties: {
													configMap: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													secret: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											certFile: type: "string"
											insecureSkipVerify: type: "boolean"
											keyFile: type: "string"
											keySecret: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											serverName: type: "string"
										}
										type: "object"
									}
								}
								required: [
									"host",
								]
								type: "object"
							}
							arbitraryFSAccessThroughSMs: {
								properties: deny: type: "boolean"
								type: "object"
							}
							bodySizeLimit: {
								pattern: "(^0|([0-9]*[.])?[0-9]+((K|M|G|T|E|P)i?)?B)$"
								type:    "string"
							}
							configMaps: {
								items: type: "string"
								type: "array"
							}
							containers: {
								items: {
									properties: {
										args: {
											items: type: "string"
											type: "array"
										}
										command: {
											items: type: "string"
											type: "array"
										}
										env: {
											items: {
												properties: {
													name: type: "string"
													value: type: "string"
													valueFrom: {
														properties: {
															configMapKeyRef: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															fieldRef: {
																properties: {
																	apiVersion: type: "string"
																	fieldPath: type: "string"
																}
																required: [
																	"fieldPath",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															resourceFieldRef: {
																properties: {
																	containerName: type: "string"
																	divisor: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	resource: type: "string"
																}
																required: [
																	"resource",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															secretKeyRef: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
														}
														type: "object"
													}
												}
												required: [
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										envFrom: {
											items: {
												properties: {
													configMapRef: {
														properties: {
															name: type: "string"
															optional: type: "boolean"
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													prefix: type: "string"
													secretRef: {
														properties: {
															name: type: "string"
															optional: type: "boolean"
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											type: "array"
										}
										image: type: "string"
										imagePullPolicy: type: "string"
										lifecycle: {
											properties: {
												postStart: {
													properties: {
														exec: {
															properties: command: {
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														httpGet: {
															properties: {
																host: type: "string"
																httpHeaders: {
																	items: {
																		properties: {
																			name: type: "string"
																			value: type: "string"
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																path: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
																scheme: type: "string"
															}
															required: [
																"port",
															]
															type: "object"
														}
														sleep: {
															properties: seconds: {
																format: "int64"
																type:   "integer"
															}
															required: [
																"seconds",
															]
															type: "object"
														}
														tcpSocket: {
															properties: {
																host: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
															}
															required: [
																"port",
															]
															type: "object"
														}
													}
													type: "object"
												}
												preStop: {
													properties: {
														exec: {
															properties: command: {
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														httpGet: {
															properties: {
																host: type: "string"
																httpHeaders: {
																	items: {
																		properties: {
																			name: type: "string"
																			value: type: "string"
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																path: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
																scheme: type: "string"
															}
															required: [
																"port",
															]
															type: "object"
														}
														sleep: {
															properties: seconds: {
																format: "int64"
																type:   "integer"
															}
															required: [
																"seconds",
															]
															type: "object"
														}
														tcpSocket: {
															properties: {
																host: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
															}
															required: [
																"port",
															]
															type: "object"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										livenessProbe: {
											properties: {
												exec: {
													properties: command: {
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													format: "int32"
													type:   "integer"
												}
												grpc: {
													properties: {
														port: {
															format: "int32"
															type:   "integer"
														}
														service: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												httpGet: {
													properties: {
														host: type: "string"
														httpHeaders: {
															items: {
																properties: {
																	name: type: "string"
																	value: type: "string"
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
														scheme: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												initialDelaySeconds: {
													format: "int32"
													type:   "integer"
												}
												periodSeconds: {
													format: "int32"
													type:   "integer"
												}
												successThreshold: {
													format: "int32"
													type:   "integer"
												}
												tcpSocket: {
													properties: {
														host: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
													}
													required: [
														"port",
													]
													type: "object"
												}
												terminationGracePeriodSeconds: {
													format: "int64"
													type:   "integer"
												}
												timeoutSeconds: {
													format: "int32"
													type:   "integer"
												}
											}
											type: "object"
										}
										name: type: "string"
										ports: {
											items: {
												properties: {
													containerPort: {
														format: "int32"
														type:   "integer"
													}
													hostIP: type: "string"
													hostPort: {
														format: "int32"
														type:   "integer"
													}
													name: type: "string"
													protocol: {
														default: "TCP"
														type:    "string"
													}
												}
												required: [
													"containerPort",
												]
												type: "object"
											}
											type: "array"
											"x-kubernetes-list-map-keys": [
												"containerPort",
												"protocol",
											]
											"x-kubernetes-list-type": "map"
										}
										readinessProbe: {
											properties: {
												exec: {
													properties: command: {
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													format: "int32"
													type:   "integer"
												}
												grpc: {
													properties: {
														port: {
															format: "int32"
															type:   "integer"
														}
														service: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												httpGet: {
													properties: {
														host: type: "string"
														httpHeaders: {
															items: {
																properties: {
																	name: type: "string"
																	value: type: "string"
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
														scheme: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												initialDelaySeconds: {
													format: "int32"
													type:   "integer"
												}
												periodSeconds: {
													format: "int32"
													type:   "integer"
												}
												successThreshold: {
													format: "int32"
													type:   "integer"
												}
												tcpSocket: {
													properties: {
														host: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
													}
													required: [
														"port",
													]
													type: "object"
												}
												terminationGracePeriodSeconds: {
													format: "int64"
													type:   "integer"
												}
												timeoutSeconds: {
													format: "int32"
													type:   "integer"
												}
											}
											type: "object"
										}
										resizePolicy: {
											items: {
												properties: {
													resourceName: type: "string"
													restartPolicy: type: "string"
												}
												required: [
													"resourceName",
													"restartPolicy",
												]
												type: "object"
											}
											type:                     "array"
											"x-kubernetes-list-type": "atomic"
										}
										resources: {
											properties: {
												claims: {
													items: {
														properties: name: type: "string"
														required: [
															"name",
														]
														type: "object"
													}
													type: "array"
													"x-kubernetes-list-map-keys": [
														"name",
													]
													"x-kubernetes-list-type": "map"
												}
												limits: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													type: "object"
												}
												requests: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													type: "object"
												}
											}
											type: "object"
										}
										restartPolicy: type: "string"
										securityContext: {
											properties: {
												allowPrivilegeEscalation: type: "boolean"
												capabilities: {
													properties: {
														add: {
															items: type: "string"
															type: "array"
														}
														drop: {
															items: type: "string"
															type: "array"
														}
													}
													type: "object"
												}
												privileged: type: "boolean"
												procMount: type: "string"
												readOnlyRootFilesystem: type: "boolean"
												runAsGroup: {
													format: "int64"
													type:   "integer"
												}
												runAsNonRoot: type: "boolean"
												runAsUser: {
													format: "int64"
													type:   "integer"
												}
												seLinuxOptions: {
													properties: {
														level: type: "string"
														role: type: "string"
														type: type: "string"
														user: type: "string"
													}
													type: "object"
												}
												seccompProfile: {
													properties: {
														localhostProfile: type: "string"
														type: type: "string"
													}
													required: [
														"type",
													]
													type: "object"
												}
												windowsOptions: {
													properties: {
														gmsaCredentialSpec: type: "string"
														gmsaCredentialSpecName: type: "string"
														hostProcess: type: "boolean"
														runAsUserName: type: "string"
													}
													type: "object"
												}
											}
											type: "object"
										}
										startupProbe: {
											properties: {
												exec: {
													properties: command: {
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													format: "int32"
													type:   "integer"
												}
												grpc: {
													properties: {
														port: {
															format: "int32"
															type:   "integer"
														}
														service: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												httpGet: {
													properties: {
														host: type: "string"
														httpHeaders: {
															items: {
																properties: {
																	name: type: "string"
																	value: type: "string"
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
														scheme: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												initialDelaySeconds: {
													format: "int32"
													type:   "integer"
												}
												periodSeconds: {
													format: "int32"
													type:   "integer"
												}
												successThreshold: {
													format: "int32"
													type:   "integer"
												}
												tcpSocket: {
													properties: {
														host: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
													}
													required: [
														"port",
													]
													type: "object"
												}
												terminationGracePeriodSeconds: {
													format: "int64"
													type:   "integer"
												}
												timeoutSeconds: {
													format: "int32"
													type:   "integer"
												}
											}
											type: "object"
										}
										stdin: type: "boolean"
										stdinOnce: type: "boolean"
										terminationMessagePath: type: "string"
										terminationMessagePolicy: type: "string"
										tty: type: "boolean"
										volumeDevices: {
											items: {
												properties: {
													devicePath: type: "string"
													name: type: "string"
												}
												required: [
													"devicePath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										volumeMounts: {
											items: {
												properties: {
													mountPath: type: "string"
													mountPropagation: type: "string"
													name: type: "string"
													readOnly: type: "boolean"
													subPath: type: "string"
													subPathExpr: type: "string"
												}
												required: [
													"mountPath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										workingDir: type: "string"
									}
									required: [
										"name",
									]
									type: "object"
								}
								type: "array"
							}
							enableFeatures: {
								items: type: "string"
								type: "array"
							}
							enableRemoteWriteReceiver: type: "boolean"
							enforcedBodySizeLimit: {
								pattern: "(^0|([0-9]*[.])?[0-9]+((K|M|G|T|E|P)i?)?B)$"
								type:    "string"
							}
							enforcedKeepDroppedTargets: {
								format: "int64"
								type:   "integer"
							}
							enforcedLabelLimit: {
								format: "int64"
								type:   "integer"
							}
							enforcedLabelNameLengthLimit: {
								format: "int64"
								type:   "integer"
							}
							enforcedLabelValueLengthLimit: {
								format: "int64"
								type:   "integer"
							}
							enforcedNamespaceLabel: type: "string"
							enforcedSampleLimit: {
								format: "int64"
								type:   "integer"
							}
							enforcedTargetLimit: {
								format: "int64"
								type:   "integer"
							}
							excludedFromEnforcement: {
								items: {
									properties: {
										group: {
											default: "monitoring.coreos.com"
											enum: [
												"monitoring.coreos.com",
											]
											type: "string"
										}
										name: type: "string"
										namespace: {
											minLength: 1
											type:      "string"
										}
										resource: {
											enum: [
												"prometheusrules",
												"servicemonitors",
												"podmonitors",
												"probes",
												"scrapeconfigs",
											]
											type: "string"
										}
									}
									required: [
										"namespace",
										"resource",
									]
									type: "object"
								}
								type: "array"
							}
							externalLabels: {
								additionalProperties: type: "string"
								type: "object"
							}
							externalUrl: type: "string"
							hostAliases: {
								items: {
									properties: {
										hostnames: {
											items: type: "string"
											type: "array"
										}
										ip: type: "string"
									}
									required: [
										"hostnames",
										"ip",
									]
									type: "object"
								}
								type: "array"
								"x-kubernetes-list-map-keys": [
									"ip",
								]
								"x-kubernetes-list-type": "map"
							}
							hostNetwork: type: "boolean"
							ignoreNamespaceSelectors: type: "boolean"
							image: type: "string"
							imagePullPolicy: {
								enum: [
									"",
									"Always",
									"Never",
									"IfNotPresent",
								]
								type: "string"
							}
							imagePullSecrets: {
								items: {
									properties: name: type: "string"
									type:                    "object"
									"x-kubernetes-map-type": "atomic"
								}
								type: "array"
							}
							initContainers: {
								items: {
									properties: {
										args: {
											items: type: "string"
											type: "array"
										}
										command: {
											items: type: "string"
											type: "array"
										}
										env: {
											items: {
												properties: {
													name: type: "string"
													value: type: "string"
													valueFrom: {
														properties: {
															configMapKeyRef: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															fieldRef: {
																properties: {
																	apiVersion: type: "string"
																	fieldPath: type: "string"
																}
																required: [
																	"fieldPath",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															resourceFieldRef: {
																properties: {
																	containerName: type: "string"
																	divisor: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	resource: type: "string"
																}
																required: [
																	"resource",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															secretKeyRef: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
														}
														type: "object"
													}
												}
												required: [
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										envFrom: {
											items: {
												properties: {
													configMapRef: {
														properties: {
															name: type: "string"
															optional: type: "boolean"
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													prefix: type: "string"
													secretRef: {
														properties: {
															name: type: "string"
															optional: type: "boolean"
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											type: "array"
										}
										image: type: "string"
										imagePullPolicy: type: "string"
										lifecycle: {
											properties: {
												postStart: {
													properties: {
														exec: {
															properties: command: {
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														httpGet: {
															properties: {
																host: type: "string"
																httpHeaders: {
																	items: {
																		properties: {
																			name: type: "string"
																			value: type: "string"
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																path: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
																scheme: type: "string"
															}
															required: [
																"port",
															]
															type: "object"
														}
														sleep: {
															properties: seconds: {
																format: "int64"
																type:   "integer"
															}
															required: [
																"seconds",
															]
															type: "object"
														}
														tcpSocket: {
															properties: {
																host: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
															}
															required: [
																"port",
															]
															type: "object"
														}
													}
													type: "object"
												}
												preStop: {
													properties: {
														exec: {
															properties: command: {
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														httpGet: {
															properties: {
																host: type: "string"
																httpHeaders: {
																	items: {
																		properties: {
																			name: type: "string"
																			value: type: "string"
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																path: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
																scheme: type: "string"
															}
															required: [
																"port",
															]
															type: "object"
														}
														sleep: {
															properties: seconds: {
																format: "int64"
																type:   "integer"
															}
															required: [
																"seconds",
															]
															type: "object"
														}
														tcpSocket: {
															properties: {
																host: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
															}
															required: [
																"port",
															]
															type: "object"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										livenessProbe: {
											properties: {
												exec: {
													properties: command: {
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													format: "int32"
													type:   "integer"
												}
												grpc: {
													properties: {
														port: {
															format: "int32"
															type:   "integer"
														}
														service: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												httpGet: {
													properties: {
														host: type: "string"
														httpHeaders: {
															items: {
																properties: {
																	name: type: "string"
																	value: type: "string"
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
														scheme: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												initialDelaySeconds: {
													format: "int32"
													type:   "integer"
												}
												periodSeconds: {
													format: "int32"
													type:   "integer"
												}
												successThreshold: {
													format: "int32"
													type:   "integer"
												}
												tcpSocket: {
													properties: {
														host: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
													}
													required: [
														"port",
													]
													type: "object"
												}
												terminationGracePeriodSeconds: {
													format: "int64"
													type:   "integer"
												}
												timeoutSeconds: {
													format: "int32"
													type:   "integer"
												}
											}
											type: "object"
										}
										name: type: "string"
										ports: {
											items: {
												properties: {
													containerPort: {
														format: "int32"
														type:   "integer"
													}
													hostIP: type: "string"
													hostPort: {
														format: "int32"
														type:   "integer"
													}
													name: type: "string"
													protocol: {
														default: "TCP"
														type:    "string"
													}
												}
												required: [
													"containerPort",
												]
												type: "object"
											}
											type: "array"
											"x-kubernetes-list-map-keys": [
												"containerPort",
												"protocol",
											]
											"x-kubernetes-list-type": "map"
										}
										readinessProbe: {
											properties: {
												exec: {
													properties: command: {
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													format: "int32"
													type:   "integer"
												}
												grpc: {
													properties: {
														port: {
															format: "int32"
															type:   "integer"
														}
														service: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												httpGet: {
													properties: {
														host: type: "string"
														httpHeaders: {
															items: {
																properties: {
																	name: type: "string"
																	value: type: "string"
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
														scheme: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												initialDelaySeconds: {
													format: "int32"
													type:   "integer"
												}
												periodSeconds: {
													format: "int32"
													type:   "integer"
												}
												successThreshold: {
													format: "int32"
													type:   "integer"
												}
												tcpSocket: {
													properties: {
														host: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
													}
													required: [
														"port",
													]
													type: "object"
												}
												terminationGracePeriodSeconds: {
													format: "int64"
													type:   "integer"
												}
												timeoutSeconds: {
													format: "int32"
													type:   "integer"
												}
											}
											type: "object"
										}
										resizePolicy: {
											items: {
												properties: {
													resourceName: type: "string"
													restartPolicy: type: "string"
												}
												required: [
													"resourceName",
													"restartPolicy",
												]
												type: "object"
											}
											type:                     "array"
											"x-kubernetes-list-type": "atomic"
										}
										resources: {
											properties: {
												claims: {
													items: {
														properties: name: type: "string"
														required: [
															"name",
														]
														type: "object"
													}
													type: "array"
													"x-kubernetes-list-map-keys": [
														"name",
													]
													"x-kubernetes-list-type": "map"
												}
												limits: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													type: "object"
												}
												requests: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													type: "object"
												}
											}
											type: "object"
										}
										restartPolicy: type: "string"
										securityContext: {
											properties: {
												allowPrivilegeEscalation: type: "boolean"
												capabilities: {
													properties: {
														add: {
															items: type: "string"
															type: "array"
														}
														drop: {
															items: type: "string"
															type: "array"
														}
													}
													type: "object"
												}
												privileged: type: "boolean"
												procMount: type: "string"
												readOnlyRootFilesystem: type: "boolean"
												runAsGroup: {
													format: "int64"
													type:   "integer"
												}
												runAsNonRoot: type: "boolean"
												runAsUser: {
													format: "int64"
													type:   "integer"
												}
												seLinuxOptions: {
													properties: {
														level: type: "string"
														role: type: "string"
														type: type: "string"
														user: type: "string"
													}
													type: "object"
												}
												seccompProfile: {
													properties: {
														localhostProfile: type: "string"
														type: type: "string"
													}
													required: [
														"type",
													]
													type: "object"
												}
												windowsOptions: {
													properties: {
														gmsaCredentialSpec: type: "string"
														gmsaCredentialSpecName: type: "string"
														hostProcess: type: "boolean"
														runAsUserName: type: "string"
													}
													type: "object"
												}
											}
											type: "object"
										}
										startupProbe: {
											properties: {
												exec: {
													properties: command: {
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													format: "int32"
													type:   "integer"
												}
												grpc: {
													properties: {
														port: {
															format: "int32"
															type:   "integer"
														}
														service: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												httpGet: {
													properties: {
														host: type: "string"
														httpHeaders: {
															items: {
																properties: {
																	name: type: "string"
																	value: type: "string"
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
														scheme: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												initialDelaySeconds: {
													format: "int32"
													type:   "integer"
												}
												periodSeconds: {
													format: "int32"
													type:   "integer"
												}
												successThreshold: {
													format: "int32"
													type:   "integer"
												}
												tcpSocket: {
													properties: {
														host: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
													}
													required: [
														"port",
													]
													type: "object"
												}
												terminationGracePeriodSeconds: {
													format: "int64"
													type:   "integer"
												}
												timeoutSeconds: {
													format: "int32"
													type:   "integer"
												}
											}
											type: "object"
										}
										stdin: type: "boolean"
										stdinOnce: type: "boolean"
										terminationMessagePath: type: "string"
										terminationMessagePolicy: type: "string"
										tty: type: "boolean"
										volumeDevices: {
											items: {
												properties: {
													devicePath: type: "string"
													name: type: "string"
												}
												required: [
													"devicePath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										volumeMounts: {
											items: {
												properties: {
													mountPath: type: "string"
													mountPropagation: type: "string"
													name: type: "string"
													readOnly: type: "boolean"
													subPath: type: "string"
													subPathExpr: type: "string"
												}
												required: [
													"mountPath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										workingDir: type: "string"
									}
									required: [
										"name",
									]
									type: "object"
								}
								type: "array"
							}
							keepDroppedTargets: {
								format: "int64"
								type:   "integer"
							}
							labelLimit: {
								format: "int64"
								type:   "integer"
							}
							labelNameLengthLimit: {
								format: "int64"
								type:   "integer"
							}
							labelValueLengthLimit: {
								format: "int64"
								type:   "integer"
							}
							listenLocal: type: "boolean"
							logFormat: {
								enum: [
									"",
									"logfmt",
									"json",
								]
								type: "string"
							}
							logLevel: {
								enum: [
									"",
									"debug",
									"info",
									"warn",
									"error",
								]
								type: "string"
							}
							maximumStartupDurationSeconds: {
								format:  "int32"
								minimum: 60
								type:    "integer"
							}
							minReadySeconds: {
								format: "int32"
								type:   "integer"
							}
							nodeSelector: {
								additionalProperties: type: "string"
								type: "object"
							}
							overrideHonorLabels: type: "boolean"
							overrideHonorTimestamps: type: "boolean"
							paused: type: "boolean"
							persistentVolumeClaimRetentionPolicy: {
								properties: {
									whenDeleted: type: "string"
									whenScaled: type: "string"
								}
								type: "object"
							}
							podMetadata: {
								properties: {
									annotations: {
										additionalProperties: type: "string"
										type: "object"
									}
									labels: {
										additionalProperties: type: "string"
										type: "object"
									}
									name: type: "string"
								}
								type: "object"
							}
							podMonitorNamespaceSelector: {
								properties: {
									matchExpressions: {
										items: {
											properties: {
												key: type: "string"
												operator: type: "string"
												values: {
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							podMonitorSelector: {
								properties: {
									matchExpressions: {
										items: {
											properties: {
												key: type: "string"
												operator: type: "string"
												values: {
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							podTargetLabels: {
								items: type: "string"
								type: "array"
							}
							portName: {
								default: "web"
								type:    "string"
							}
							priorityClassName: type: "string"
							probeNamespaceSelector: {
								properties: {
									matchExpressions: {
										items: {
											properties: {
												key: type: "string"
												operator: type: "string"
												values: {
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							probeSelector: {
								properties: {
									matchExpressions: {
										items: {
											properties: {
												key: type: "string"
												operator: type: "string"
												values: {
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							prometheusExternalLabelName: type: "string"
							reloadStrategy: {
								enum: [
									"HTTP",
									"ProcessSignal",
								]
								type: "string"
							}
							remoteWrite: {
								items: {
									properties: {
										authorization: {
											properties: {
												credentials: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												credentialsFile: type: "string"
												type: type: "string"
											}
											type: "object"
										}
										azureAd: {
											properties: {
												cloud: {
													enum: [
														"AzureChina",
														"AzureGovernment",
														"AzurePublic",
													]
													type: "string"
												}
												managedIdentity: {
													properties: clientId: type: "string"
													required: [
														"clientId",
													]
													type: "object"
												}
												oauth: {
													properties: {
														clientId: {
															minLength: 1
															type:      "string"
														}
														clientSecret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														tenantId: {
															minLength: 1
															pattern:   "^[0-9a-zA-Z-.]+$"
															type:      "string"
														}
													}
													required: [
														"clientId",
														"clientSecret",
														"tenantId",
													]
													type: "object"
												}
											}
											type: "object"
										}
										basicAuth: {
											properties: {
												password: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												username: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
											}
											type: "object"
										}
										bearerToken: type: "string"
										bearerTokenFile: type: "string"
										enableHTTP2: type: "boolean"
										headers: {
											additionalProperties: type: "string"
											type: "object"
										}
										metadataConfig: {
											properties: {
												send: type: "boolean"
												sendInterval: {
													pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
													type:    "string"
												}
											}
											type: "object"
										}
										name: type: "string"
										oauth2: {
											properties: {
												clientId: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												clientSecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												endpointParams: {
													additionalProperties: type: "string"
													type: "object"
												}
												scopes: {
													items: type: "string"
													type: "array"
												}
												tokenUrl: {
													minLength: 1
													type:      "string"
												}
											}
											required: [
												"clientId",
												"clientSecret",
												"tokenUrl",
											]
											type: "object"
										}
										proxyUrl: type: "string"
										queueConfig: {
											properties: {
												batchSendDeadline: type: "string"
												capacity: type: "integer"
												maxBackoff: type: "string"
												maxRetries: type: "integer"
												maxSamplesPerSend: type: "integer"
												maxShards: type: "integer"
												minBackoff: type: "string"
												minShards: type: "integer"
												retryOnRateLimit: type: "boolean"
											}
											type: "object"
										}
										remoteTimeout: {
											pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
											type:    "string"
										}
										sendExemplars: type: "boolean"
										sendNativeHistograms: type: "boolean"
										sigv4: {
											properties: {
												accessKey: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												profile: type: "string"
												region: type: "string"
												roleArn: type: "string"
												secretKey: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
											}
											type: "object"
										}
										tlsConfig: {
											properties: {
												ca: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												caFile: type: "string"
												cert: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												certFile: type: "string"
												insecureSkipVerify: type: "boolean"
												keyFile: type: "string"
												keySecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												serverName: type: "string"
											}
											type: "object"
										}
										url: type: "string"
										writeRelabelConfigs: {
											items: {
												properties: {
													action: {
														default: "replace"
														enum: [
															"replace",
															"Replace",
															"keep",
															"Keep",
															"drop",
															"Drop",
															"hashmod",
															"HashMod",
															"labelmap",
															"LabelMap",
															"labeldrop",
															"LabelDrop",
															"labelkeep",
															"LabelKeep",
															"lowercase",
															"Lowercase",
															"uppercase",
															"Uppercase",
															"keepequal",
															"KeepEqual",
															"dropequal",
															"DropEqual",
														]
														type: "string"
													}
													modulus: {
														format: "int64"
														type:   "integer"
													}
													regex: type: "string"
													replacement: type: "string"
													separator: type: "string"
													sourceLabels: {
														items: {
															pattern: "^[a-zA-Z_][a-zA-Z0-9_]*$"
															type:    "string"
														}
														type: "array"
													}
													targetLabel: type: "string"
												}
												type: "object"
											}
											type: "array"
										}
									}
									required: [
										"url",
									]
									type: "object"
								}
								type: "array"
							}
							replicaExternalLabelName: type: "string"
							replicas: {
								format: "int32"
								type:   "integer"
							}
							resources: {
								properties: {
									claims: {
										items: {
											properties: name: type: "string"
											required: [
												"name",
											]
											type: "object"
										}
										type: "array"
										"x-kubernetes-list-map-keys": [
											"name",
										]
										"x-kubernetes-list-type": "map"
									}
									limits: {
										additionalProperties: {
											anyOf: [{
												type: "integer"
											}, {
												type: "string"
											}]
											pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
											"x-kubernetes-int-or-string": true
										}
										type: "object"
									}
									requests: {
										additionalProperties: {
											anyOf: [{
												type: "integer"
											}, {
												type: "string"
											}]
											pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
											"x-kubernetes-int-or-string": true
										}
										type: "object"
									}
								}
								type: "object"
							}
							routePrefix: type: "string"
							sampleLimit: {
								format: "int64"
								type:   "integer"
							}
							scrapeClasses: {
								items: {
									properties: {
										default: type: "boolean"
										name: {
											minLength: 1
											type:      "string"
										}
										tlsConfig: {
											properties: {
												ca: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												caFile: type: "string"
												cert: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												certFile: type: "string"
												insecureSkipVerify: type: "boolean"
												keyFile: type: "string"
												keySecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												serverName: type: "string"
											}
											type: "object"
										}
									}
									required: [
										"name",
									]
									type: "object"
								}
								type: "array"
								"x-kubernetes-list-map-keys": [
									"name",
								]
								"x-kubernetes-list-type": "map"
							}
							scrapeConfigNamespaceSelector: {
								properties: {
									matchExpressions: {
										items: {
											properties: {
												key: type: "string"
												operator: type: "string"
												values: {
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							scrapeConfigSelector: {
								properties: {
									matchExpressions: {
										items: {
											properties: {
												key: type: "string"
												operator: type: "string"
												values: {
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							scrapeInterval: {
								default: "30s"
								pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
								type:    "string"
							}
							scrapeProtocols: {
								items: {
									enum: [
										"PrometheusProto",
										"OpenMetricsText0.0.1",
										"OpenMetricsText1.0.0",
										"PrometheusText0.0.4",
									]
									type: "string"
								}
								type:                     "array"
								"x-kubernetes-list-type": "set"
							}
							scrapeTimeout: {
								pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
								type:    "string"
							}
							secrets: {
								items: type: "string"
								type: "array"
							}
							securityContext: {
								properties: {
									fsGroup: {
										format: "int64"
										type:   "integer"
									}
									fsGroupChangePolicy: type: "string"
									runAsGroup: {
										format: "int64"
										type:   "integer"
									}
									runAsNonRoot: type: "boolean"
									runAsUser: {
										format: "int64"
										type:   "integer"
									}
									seLinuxOptions: {
										properties: {
											level: type: "string"
											role: type: "string"
											type: type: "string"
											user: type: "string"
										}
										type: "object"
									}
									seccompProfile: {
										properties: {
											localhostProfile: type: "string"
											type: type: "string"
										}
										required: [
											"type",
										]
										type: "object"
									}
									supplementalGroups: {
										items: {
											format: "int64"
											type:   "integer"
										}
										type: "array"
									}
									sysctls: {
										items: {
											properties: {
												name: type: "string"
												value: type: "string"
											}
											required: [
												"name",
												"value",
											]
											type: "object"
										}
										type: "array"
									}
									windowsOptions: {
										properties: {
											gmsaCredentialSpec: type: "string"
											gmsaCredentialSpecName: type: "string"
											hostProcess: type: "boolean"
											runAsUserName: type: "string"
										}
										type: "object"
									}
								}
								type: "object"
							}
							serviceAccountName: type: "string"
							serviceMonitorNamespaceSelector: {
								properties: {
									matchExpressions: {
										items: {
											properties: {
												key: type: "string"
												operator: type: "string"
												values: {
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							serviceMonitorSelector: {
								properties: {
									matchExpressions: {
										items: {
											properties: {
												key: type: "string"
												operator: type: "string"
												values: {
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							shards: {
								format: "int32"
								type:   "integer"
							}
							storage: {
								properties: {
									disableMountSubPath: type: "boolean"
									emptyDir: {
										properties: {
											medium: type: "string"
											sizeLimit: {
												anyOf: [{
													type: "integer"
												}, {
													type: "string"
												}]
												pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
												"x-kubernetes-int-or-string": true
											}
										}
										type: "object"
									}
									ephemeral: {
										properties: volumeClaimTemplate: {
											properties: {
												metadata: type: "object"
												spec: {
													properties: {
														accessModes: {
															items: type: "string"
															type: "array"
														}
														dataSource: {
															properties: {
																apiGroup: type: "string"
																kind: type: "string"
																name: type: "string"
															}
															required: [
																"kind",
																"name",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														dataSourceRef: {
															properties: {
																apiGroup: type: "string"
																kind: type: "string"
																name: type: "string"
																namespace: type: "string"
															}
															required: [
																"kind",
																"name",
															]
															type: "object"
														}
														resources: {
															properties: {
																limits: {
																	additionalProperties: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	type: "object"
																}
																requests: {
																	additionalProperties: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	type: "object"
																}
															}
															type: "object"
														}
														selector: {
															properties: {
																matchExpressions: {
																	items: {
																		properties: {
																			key: type: "string"
																			operator: type: "string"
																			values: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														storageClassName: type: "string"
														volumeAttributesClassName: type: "string"
														volumeMode: type: "string"
														volumeName: type: "string"
													}
													type: "object"
												}
											}
											required: [
												"spec",
											]
											type: "object"
										}
										type: "object"
									}
									volumeClaimTemplate: {
										properties: {
											apiVersion: type: "string"
											kind: type: "string"
											metadata: {
												properties: {
													annotations: {
														additionalProperties: type: "string"
														type: "object"
													}
													labels: {
														additionalProperties: type: "string"
														type: "object"
													}
													name: type: "string"
												}
												type: "object"
											}
											spec: {
												properties: {
													accessModes: {
														items: type: "string"
														type: "array"
													}
													dataSource: {
														properties: {
															apiGroup: type: "string"
															kind: type: "string"
															name: type: "string"
														}
														required: [
															"kind",
															"name",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													dataSourceRef: {
														properties: {
															apiGroup: type: "string"
															kind: type: "string"
															name: type: "string"
															namespace: type: "string"
														}
														required: [
															"kind",
															"name",
														]
														type: "object"
													}
													resources: {
														properties: {
															limits: {
																additionalProperties: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																	"x-kubernetes-int-or-string": true
																}
																type: "object"
															}
															requests: {
																additionalProperties: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																	"x-kubernetes-int-or-string": true
																}
																type: "object"
															}
														}
														type: "object"
													}
													selector: {
														properties: {
															matchExpressions: {
																items: {
																	properties: {
																		key: type: "string"
																		operator: type: "string"
																		values: {
																			items: type: "string"
																			type: "array"
																		}
																	}
																	required: [
																		"key",
																		"operator",
																	]
																	type: "object"
																}
																type: "array"
															}
															matchLabels: {
																additionalProperties: type: "string"
																type: "object"
															}
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													storageClassName: type: "string"
													volumeAttributesClassName: type: "string"
													volumeMode: type: "string"
													volumeName: type: "string"
												}
												type: "object"
											}
											status: {
												properties: {
													accessModes: {
														items: type: "string"
														type: "array"
													}
													allocatedResourceStatuses: {
														additionalProperties: type: "string"
														type:                    "object"
														"x-kubernetes-map-type": "granular"
													}
													allocatedResources: {
														additionalProperties: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
															"x-kubernetes-int-or-string": true
														}
														type: "object"
													}
													capacity: {
														additionalProperties: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
															"x-kubernetes-int-or-string": true
														}
														type: "object"
													}
													conditions: {
														items: {
															properties: {
																lastProbeTime: {
																	format: "date-time"
																	type:   "string"
																}
																lastTransitionTime: {
																	format: "date-time"
																	type:   "string"
																}
																message: type: "string"
																reason: type: "string"
																status: type: "string"
																type: type: "string"
															}
															required: [
																"status",
																"type",
															]
															type: "object"
														}
														type: "array"
													}
													currentVolumeAttributesClassName: type: "string"
													modifyVolumeStatus: {
														properties: {
															status: type: "string"
															targetVolumeAttributesClassName: type: "string"
														}
														required: [
															"status",
														]
														type: "object"
													}
													phase: type: "string"
												}
												type: "object"
											}
										}
										type: "object"
									}
								}
								type: "object"
							}
							targetLimit: {
								format: "int64"
								type:   "integer"
							}
							tolerations: {
								items: {
									properties: {
										effect: type: "string"
										key: type: "string"
										operator: type: "string"
										tolerationSeconds: {
											format: "int64"
											type:   "integer"
										}
										value: type: "string"
									}
									type: "object"
								}
								type: "array"
							}
							topologySpreadConstraints: {
								items: {
									properties: {
										additionalLabelSelectors: {
											enum: [
												"OnResource",
												"OnShard",
											]
											type: "string"
										}
										labelSelector: {
											properties: {
												matchExpressions: {
													items: {
														properties: {
															key: type: "string"
															operator: type: "string"
															values: {
																items: type: "string"
																type: "array"
															}
														}
														required: [
															"key",
															"operator",
														]
														type: "object"
													}
													type: "array"
												}
												matchLabels: {
													additionalProperties: type: "string"
													type: "object"
												}
											}
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										matchLabelKeys: {
											items: type: "string"
											type:                     "array"
											"x-kubernetes-list-type": "atomic"
										}
										maxSkew: {
											format: "int32"
											type:   "integer"
										}
										minDomains: {
											format: "int32"
											type:   "integer"
										}
										nodeAffinityPolicy: type: "string"
										nodeTaintsPolicy: type: "string"
										topologyKey: type: "string"
										whenUnsatisfiable: type: "string"
									}
									required: [
										"maxSkew",
										"topologyKey",
										"whenUnsatisfiable",
									]
									type: "object"
								}
								type: "array"
							}
							tracingConfig: {
								properties: {
									clientType: {
										enum: [
											"http",
											"grpc",
										]
										type: "string"
									}
									compression: {
										enum: [
											"gzip",
										]
										type: "string"
									}
									endpoint: {
										minLength: 1
										type:      "string"
									}
									headers: {
										additionalProperties: type: "string"
										type: "object"
									}
									insecure: type: "boolean"
									samplingFraction: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
										"x-kubernetes-int-or-string": true
									}
									timeout: {
										pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
										type:    "string"
									}
									tlsConfig: {
										properties: {
											ca: {
												properties: {
													configMap: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													secret: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											caFile: type: "string"
											cert: {
												properties: {
													configMap: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													secret: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											certFile: type: "string"
											insecureSkipVerify: type: "boolean"
											keyFile: type: "string"
											keySecret: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											serverName: type: "string"
										}
										type: "object"
									}
								}
								required: [
									"endpoint",
								]
								type: "object"
							}
							version: type: "string"
							volumeMounts: {
								items: {
									properties: {
										mountPath: type: "string"
										mountPropagation: type: "string"
										name: type: "string"
										readOnly: type: "boolean"
										subPath: type: "string"
										subPathExpr: type: "string"
									}
									required: [
										"mountPath",
										"name",
									]
									type: "object"
								}
								type: "array"
							}
							volumes: {
								items: {
									properties: {
										awsElasticBlockStore: {
											properties: {
												fsType: type: "string"
												partition: {
													format: "int32"
													type:   "integer"
												}
												readOnly: type: "boolean"
												volumeID: type: "string"
											}
											required: [
												"volumeID",
											]
											type: "object"
										}
										azureDisk: {
											properties: {
												cachingMode: type: "string"
												diskName: type: "string"
												diskURI: type: "string"
												fsType: type: "string"
												kind: type: "string"
												readOnly: type: "boolean"
											}
											required: [
												"diskName",
												"diskURI",
											]
											type: "object"
										}
										azureFile: {
											properties: {
												readOnly: type: "boolean"
												secretName: type: "string"
												shareName: type: "string"
											}
											required: [
												"secretName",
												"shareName",
											]
											type: "object"
										}
										cephfs: {
											properties: {
												monitors: {
													items: type: "string"
													type: "array"
												}
												path: type: "string"
												readOnly: type: "boolean"
												secretFile: type: "string"
												secretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												user: type: "string"
											}
											required: [
												"monitors",
											]
											type: "object"
										}
										cinder: {
											properties: {
												fsType: type: "string"
												readOnly: type: "boolean"
												secretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												volumeID: type: "string"
											}
											required: [
												"volumeID",
											]
											type: "object"
										}
										configMap: {
											properties: {
												defaultMode: {
													format: "int32"
													type:   "integer"
												}
												items: {
													items: {
														properties: {
															key: type: "string"
															mode: {
																format: "int32"
																type:   "integer"
															}
															path: type: "string"
														}
														required: [
															"key",
															"path",
														]
														type: "object"
													}
													type: "array"
												}
												name: type: "string"
												optional: type: "boolean"
											}
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										csi: {
											properties: {
												driver: type: "string"
												fsType: type: "string"
												nodePublishSecretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												readOnly: type: "boolean"
												volumeAttributes: {
													additionalProperties: type: "string"
													type: "object"
												}
											}
											required: [
												"driver",
											]
											type: "object"
										}
										downwardAPI: {
											properties: {
												defaultMode: {
													format: "int32"
													type:   "integer"
												}
												items: {
													items: {
														properties: {
															fieldRef: {
																properties: {
																	apiVersion: type: "string"
																	fieldPath: type: "string"
																}
																required: [
																	"fieldPath",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															mode: {
																format: "int32"
																type:   "integer"
															}
															path: type: "string"
															resourceFieldRef: {
																properties: {
																	containerName: type: "string"
																	divisor: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	resource: type: "string"
																}
																required: [
																	"resource",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
														}
														required: [
															"path",
														]
														type: "object"
													}
													type: "array"
												}
											}
											type: "object"
										}
										emptyDir: {
											properties: {
												medium: type: "string"
												sizeLimit: {
													anyOf: [{
														type: "integer"
													}, {
														type: "string"
													}]
													pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
													"x-kubernetes-int-or-string": true
												}
											}
											type: "object"
										}
										ephemeral: {
											properties: volumeClaimTemplate: {
												properties: {
													metadata: type: "object"
													spec: {
														properties: {
															accessModes: {
																items: type: "string"
																type: "array"
															}
															dataSource: {
																properties: {
																	apiGroup: type: "string"
																	kind: type: "string"
																	name: type: "string"
																}
																required: [
																	"kind",
																	"name",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															dataSourceRef: {
																properties: {
																	apiGroup: type: "string"
																	kind: type: "string"
																	name: type: "string"
																	namespace: type: "string"
																}
																required: [
																	"kind",
																	"name",
																]
																type: "object"
															}
															resources: {
																properties: {
																	limits: {
																		additionalProperties: {
																			anyOf: [{
																				type: "integer"
																			}, {
																				type: "string"
																			}]
																			pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																			"x-kubernetes-int-or-string": true
																		}
																		type: "object"
																	}
																	requests: {
																		additionalProperties: {
																			anyOf: [{
																				type: "integer"
																			}, {
																				type: "string"
																			}]
																			pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																			"x-kubernetes-int-or-string": true
																		}
																		type: "object"
																	}
																}
																type: "object"
															}
															selector: {
																properties: {
																	matchExpressions: {
																		items: {
																			properties: {
																				key: type: "string"
																				operator: type: "string"
																				values: {
																					items: type: "string"
																					type: "array"
																				}
																			}
																			required: [
																				"key",
																				"operator",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	matchLabels: {
																		additionalProperties: type: "string"
																		type: "object"
																	}
																}
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															storageClassName: type: "string"
															volumeAttributesClassName: type: "string"
															volumeMode: type: "string"
															volumeName: type: "string"
														}
														type: "object"
													}
												}
												required: [
													"spec",
												]
												type: "object"
											}
											type: "object"
										}
										fc: {
											properties: {
												fsType: type: "string"
												lun: {
													format: "int32"
													type:   "integer"
												}
												readOnly: type: "boolean"
												targetWWNs: {
													items: type: "string"
													type: "array"
												}
												wwids: {
													items: type: "string"
													type: "array"
												}
											}
											type: "object"
										}
										flexVolume: {
											properties: {
												driver: type: "string"
												fsType: type: "string"
												options: {
													additionalProperties: type: "string"
													type: "object"
												}
												readOnly: type: "boolean"
												secretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
											}
											required: [
												"driver",
											]
											type: "object"
										}
										flocker: {
											properties: {
												datasetName: type: "string"
												datasetUUID: type: "string"
											}
											type: "object"
										}
										gcePersistentDisk: {
											properties: {
												fsType: type: "string"
												partition: {
													format: "int32"
													type:   "integer"
												}
												pdName: type: "string"
												readOnly: type: "boolean"
											}
											required: [
												"pdName",
											]
											type: "object"
										}
										gitRepo: {
											properties: {
												directory: type: "string"
												repository: type: "string"
												revision: type: "string"
											}
											required: [
												"repository",
											]
											type: "object"
										}
										glusterfs: {
											properties: {
												endpoints: type: "string"
												path: type: "string"
												readOnly: type: "boolean"
											}
											required: [
												"endpoints",
												"path",
											]
											type: "object"
										}
										hostPath: {
											properties: {
												path: type: "string"
												type: type: "string"
											}
											required: [
												"path",
											]
											type: "object"
										}
										iscsi: {
											properties: {
												chapAuthDiscovery: type: "boolean"
												chapAuthSession: type: "boolean"
												fsType: type: "string"
												initiatorName: type: "string"
												iqn: type: "string"
												iscsiInterface: type: "string"
												lun: {
													format: "int32"
													type:   "integer"
												}
												portals: {
													items: type: "string"
													type: "array"
												}
												readOnly: type: "boolean"
												secretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												targetPortal: type: "string"
											}
											required: [
												"iqn",
												"lun",
												"targetPortal",
											]
											type: "object"
										}
										name: type: "string"
										nfs: {
											properties: {
												path: type: "string"
												readOnly: type: "boolean"
												server: type: "string"
											}
											required: [
												"path",
												"server",
											]
											type: "object"
										}
										persistentVolumeClaim: {
											properties: {
												claimName: type: "string"
												readOnly: type: "boolean"
											}
											required: [
												"claimName",
											]
											type: "object"
										}
										photonPersistentDisk: {
											properties: {
												fsType: type: "string"
												pdID: type: "string"
											}
											required: [
												"pdID",
											]
											type: "object"
										}
										portworxVolume: {
											properties: {
												fsType: type: "string"
												readOnly: type: "boolean"
												volumeID: type: "string"
											}
											required: [
												"volumeID",
											]
											type: "object"
										}
										projected: {
											properties: {
												defaultMode: {
													format: "int32"
													type:   "integer"
												}
												sources: {
													items: {
														properties: {
															clusterTrustBundle: {
																properties: {
																	labelSelector: {
																		properties: {
																			matchExpressions: {
																				items: {
																					properties: {
																						key: type: "string"
																						operator: type: "string"
																						values: {
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			matchLabels: {
																				additionalProperties: type: "string"
																				type: "object"
																			}
																		}
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	name: type: "string"
																	optional: type: "boolean"
																	path: type: "string"
																	signerName: type: "string"
																}
																required: [
																	"path",
																]
																type: "object"
															}
															configMap: {
																properties: {
																	items: {
																		items: {
																			properties: {
																				key: type: "string"
																				mode: {
																					format: "int32"
																					type:   "integer"
																				}
																				path: type: "string"
																			}
																			required: [
																				"key",
																				"path",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	name: type: "string"
																	optional: type: "boolean"
																}
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															downwardAPI: {
																properties: items: {
																	items: {
																		properties: {
																			fieldRef: {
																				properties: {
																					apiVersion: type: "string"
																					fieldPath: type: "string"
																				}
																				required: [
																					"fieldPath",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			mode: {
																				format: "int32"
																				type:   "integer"
																			}
																			path: type: "string"
																			resourceFieldRef: {
																				properties: {
																					containerName: type: "string"
																					divisor: {
																						anyOf: [{
																							type: "integer"
																						}, {
																							type: "string"
																						}]
																						pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																						"x-kubernetes-int-or-string": true
																					}
																					resource: type: "string"
																				}
																				required: [
																					"resource",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		required: [
																			"path",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																type: "object"
															}
															secret: {
																properties: {
																	items: {
																		items: {
																			properties: {
																				key: type: "string"
																				mode: {
																					format: "int32"
																					type:   "integer"
																				}
																				path: type: "string"
																			}
																			required: [
																				"key",
																				"path",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	name: type: "string"
																	optional: type: "boolean"
																}
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															serviceAccountToken: {
																properties: {
																	audience: type: "string"
																	expirationSeconds: {
																		format: "int64"
																		type:   "integer"
																	}
																	path: type: "string"
																}
																required: [
																	"path",
																]
																type: "object"
															}
														}
														type: "object"
													}
													type: "array"
												}
											}
											type: "object"
										}
										quobyte: {
											properties: {
												group: type: "string"
												readOnly: type: "boolean"
												registry: type: "string"
												tenant: type: "string"
												user: type: "string"
												volume: type: "string"
											}
											required: [
												"registry",
												"volume",
											]
											type: "object"
										}
										rbd: {
											properties: {
												fsType: type: "string"
												image: type: "string"
												keyring: type: "string"
												monitors: {
													items: type: "string"
													type: "array"
												}
												pool: type: "string"
												readOnly: type: "boolean"
												secretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												user: type: "string"
											}
											required: [
												"image",
												"monitors",
											]
											type: "object"
										}
										scaleIO: {
											properties: {
												fsType: type: "string"
												gateway: type: "string"
												protectionDomain: type: "string"
												readOnly: type: "boolean"
												secretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												sslEnabled: type: "boolean"
												storageMode: type: "string"
												storagePool: type: "string"
												system: type: "string"
												volumeName: type: "string"
											}
											required: [
												"gateway",
												"secretRef",
												"system",
											]
											type: "object"
										}
										secret: {
											properties: {
												defaultMode: {
													format: "int32"
													type:   "integer"
												}
												items: {
													items: {
														properties: {
															key: type: "string"
															mode: {
																format: "int32"
																type:   "integer"
															}
															path: type: "string"
														}
														required: [
															"key",
															"path",
														]
														type: "object"
													}
													type: "array"
												}
												optional: type: "boolean"
												secretName: type: "string"
											}
											type: "object"
										}
										storageos: {
											properties: {
												fsType: type: "string"
												readOnly: type: "boolean"
												secretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												volumeName: type: "string"
												volumeNamespace: type: "string"
											}
											type: "object"
										}
										vsphereVolume: {
											properties: {
												fsType: type: "string"
												storagePolicyID: type: "string"
												storagePolicyName: type: "string"
												volumePath: type: "string"
											}
											required: [
												"volumePath",
											]
											type: "object"
										}
									}
									required: [
										"name",
									]
									type: "object"
								}
								type: "array"
							}
							walCompression: type: "boolean"
							web: {
								properties: {
									httpConfig: {
										properties: {
											headers: {
												properties: {
													contentSecurityPolicy: type: "string"
													strictTransportSecurity: type: "string"
													xContentTypeOptions: {
														enum: [
															"",
															"NoSniff",
														]
														type: "string"
													}
													xFrameOptions: {
														enum: [
															"",
															"Deny",
															"SameOrigin",
														]
														type: "string"
													}
													xXSSProtection: type: "string"
												}
												type: "object"
											}
											http2: type: "boolean"
										}
										type: "object"
									}
									maxConnections: {
										format:  "int32"
										minimum: 0
										type:    "integer"
									}
									pageTitle: type: "string"
									tlsConfig: {
										properties: {
											cert: {
												properties: {
													configMap: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													secret: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											cipherSuites: {
												items: type: "string"
												type: "array"
											}
											client_ca: {
												properties: {
													configMap: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													secret: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											clientAuthType: type: "string"
											curvePreferences: {
												items: type: "string"
												type: "array"
											}
											keySecret: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											maxVersion: type: "string"
											minVersion: type: "string"
											preferServerCipherSuites: type: "boolean"
										}
										required: [
											"cert",
											"keySecret",
										]
										type: "object"
									}
								}
								type: "object"
							}
						}
						type: "object"
					}
					status: {
						properties: {
							availableReplicas: {
								format: "int32"
								type:   "integer"
							}
							conditions: {
								items: {
									properties: {
										lastTransitionTime: {
											format: "date-time"
											type:   "string"
										}
										message: type: "string"
										observedGeneration: {
											format: "int64"
											type:   "integer"
										}
										reason: type: "string"
										status: type: "string"
										type: type: "string"
									}
									required: [
										"lastTransitionTime",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
								"x-kubernetes-list-map-keys": [
									"type",
								]
								"x-kubernetes-list-type": "map"
							}
							paused: type: "boolean"
							replicas: {
								format: "int32"
								type:   "integer"
							}
							selector: type: "string"
							shardStatuses: {
								items: {
									properties: {
										availableReplicas: {
											format: "int32"
											type:   "integer"
										}
										replicas: {
											format: "int32"
											type:   "integer"
										}
										shardID: type: "string"
										unavailableReplicas: {
											format: "int32"
											type:   "integer"
										}
										updatedReplicas: {
											format: "int32"
											type:   "integer"
										}
									}
									required: [
										"availableReplicas",
										"replicas",
										"shardID",
										"unavailableReplicas",
										"updatedReplicas",
									]
									type: "object"
								}
								type: "array"
								"x-kubernetes-list-map-keys": [
									"shardID",
								]
								"x-kubernetes-list-type": "map"
							}
							shards: {
								format: "int32"
								type:   "integer"
							}
							unavailableReplicas: {
								format: "int32"
								type:   "integer"
							}
							updatedReplicas: {
								format: "int32"
								type:   "integer"
							}
						}
						required: [
							"availableReplicas",
							"paused",
							"replicas",
							"unavailableReplicas",
							"updatedReplicas",
						]
						type: "object"
					}
				}
				required: [
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
			subresources: {
				scale: {
					labelSelectorPath:  ".status.selector"
					specReplicasPath:   ".spec.shards"
					statusReplicasPath: ".status.shards"
				}
				status: {}
			}
		}]
	}
}, {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: {
			"controller-gen.kubebuilder.io/version": "v0.13.0"
			"operator.prometheus.io/version":        "0.72.0"
		}
		name: "prometheuses.monitoring.coreos.com"
	}
	spec: {
		group: "monitoring.coreos.com"
		names: {
			categories: [
				"prometheus-operator",
			]
			kind:     "Prometheus"
			listKind: "PrometheusList"
			plural:   "prometheuses"
			shortNames: [
				"prom",
			]
			singular: "prometheus"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".spec.version"
				name:     "Version"
				type:     "string"
			}, {
				jsonPath: ".spec.replicas"
				name:     "Desired"
				type:     "integer"
			}, {
				jsonPath: ".status.availableReplicas"
				name:     "Ready"
				type:     "integer"
			}, {
				jsonPath: ".status.conditions[?(@.type == 'Reconciled')].status"
				name:     "Reconciled"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type == 'Available')].status"
				name:     "Available"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}, {
				jsonPath: ".status.paused"
				name:     "Paused"
				priority: 1
				type:     "boolean"
			}]
			name: "v1"
			schema: openAPIV3Schema: {
				properties: {
					apiVersion: type: "string"
					kind: type: "string"
					metadata: type: "object"
					spec: {
						properties: {
							additionalAlertManagerConfigs: {
								properties: {
									key: type: "string"
									name: type: "string"
									optional: type: "boolean"
								}
								required: [
									"key",
								]
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							additionalAlertRelabelConfigs: {
								properties: {
									key: type: "string"
									name: type: "string"
									optional: type: "boolean"
								}
								required: [
									"key",
								]
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							additionalArgs: {
								items: {
									properties: {
										name: {
											minLength: 1
											type:      "string"
										}
										value: type: "string"
									}
									required: [
										"name",
									]
									type: "object"
								}
								type: "array"
							}
							additionalScrapeConfigs: {
								properties: {
									key: type: "string"
									name: type: "string"
									optional: type: "boolean"
								}
								required: [
									"key",
								]
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							affinity: {
								properties: {
									nodeAffinity: {
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												items: {
													properties: {
														preference: {
															properties: {
																matchExpressions: {
																	items: {
																		properties: {
																			key: type: "string"
																			operator: type: "string"
																			values: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchFields: {
																	items: {
																		properties: {
																			key: type: "string"
																			operator: type: "string"
																			values: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														weight: {
															format: "int32"
															type:   "integer"
														}
													}
													required: [
														"preference",
														"weight",
													]
													type: "object"
												}
												type: "array"
											}
											requiredDuringSchedulingIgnoredDuringExecution: {
												properties: nodeSelectorTerms: {
													items: {
														properties: {
															matchExpressions: {
																items: {
																	properties: {
																		key: type: "string"
																		operator: type: "string"
																		values: {
																			items: type: "string"
																			type: "array"
																		}
																	}
																	required: [
																		"key",
																		"operator",
																	]
																	type: "object"
																}
																type: "array"
															}
															matchFields: {
																items: {
																	properties: {
																		key: type: "string"
																		operator: type: "string"
																		values: {
																			items: type: "string"
																			type: "array"
																		}
																	}
																	required: [
																		"key",
																		"operator",
																	]
																	type: "object"
																}
																type: "array"
															}
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													type: "array"
												}
												required: [
													"nodeSelectorTerms",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
										}
										type: "object"
									}
									podAffinity: {
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												items: {
													properties: {
														podAffinityTerm: {
															properties: {
																labelSelector: {
																	properties: {
																		matchExpressions: {
																			items: {
																				properties: {
																					key: type: "string"
																					operator: type: "string"
																					values: {
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchLabels: {
																			additionalProperties: type: "string"
																			type: "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																matchLabelKeys: {
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																mismatchLabelKeys: {
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																namespaceSelector: {
																	properties: {
																		matchExpressions: {
																			items: {
																				properties: {
																					key: type: "string"
																					operator: type: "string"
																					values: {
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchLabels: {
																			additionalProperties: type: "string"
																			type: "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																namespaces: {
																	items: type: "string"
																	type: "array"
																}
																topologyKey: type: "string"
															}
															required: [
																"topologyKey",
															]
															type: "object"
														}
														weight: {
															format: "int32"
															type:   "integer"
														}
													}
													required: [
														"podAffinityTerm",
														"weight",
													]
													type: "object"
												}
												type: "array"
											}
											requiredDuringSchedulingIgnoredDuringExecution: {
												items: {
													properties: {
														labelSelector: {
															properties: {
																matchExpressions: {
																	items: {
																		properties: {
																			key: type: "string"
																			operator: type: "string"
																			values: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														matchLabelKeys: {
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														mismatchLabelKeys: {
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														namespaceSelector: {
															properties: {
																matchExpressions: {
																	items: {
																		properties: {
																			key: type: "string"
																			operator: type: "string"
																			values: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														namespaces: {
															items: type: "string"
															type: "array"
														}
														topologyKey: type: "string"
													}
													required: [
														"topologyKey",
													]
													type: "object"
												}
												type: "array"
											}
										}
										type: "object"
									}
									podAntiAffinity: {
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												items: {
													properties: {
														podAffinityTerm: {
															properties: {
																labelSelector: {
																	properties: {
																		matchExpressions: {
																			items: {
																				properties: {
																					key: type: "string"
																					operator: type: "string"
																					values: {
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchLabels: {
																			additionalProperties: type: "string"
																			type: "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																matchLabelKeys: {
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																mismatchLabelKeys: {
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																namespaceSelector: {
																	properties: {
																		matchExpressions: {
																			items: {
																				properties: {
																					key: type: "string"
																					operator: type: "string"
																					values: {
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchLabels: {
																			additionalProperties: type: "string"
																			type: "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																namespaces: {
																	items: type: "string"
																	type: "array"
																}
																topologyKey: type: "string"
															}
															required: [
																"topologyKey",
															]
															type: "object"
														}
														weight: {
															format: "int32"
															type:   "integer"
														}
													}
													required: [
														"podAffinityTerm",
														"weight",
													]
													type: "object"
												}
												type: "array"
											}
											requiredDuringSchedulingIgnoredDuringExecution: {
												items: {
													properties: {
														labelSelector: {
															properties: {
																matchExpressions: {
																	items: {
																		properties: {
																			key: type: "string"
																			operator: type: "string"
																			values: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														matchLabelKeys: {
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														mismatchLabelKeys: {
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														namespaceSelector: {
															properties: {
																matchExpressions: {
																	items: {
																		properties: {
																			key: type: "string"
																			operator: type: "string"
																			values: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														namespaces: {
															items: type: "string"
															type: "array"
														}
														topologyKey: type: "string"
													}
													required: [
														"topologyKey",
													]
													type: "object"
												}
												type: "array"
											}
										}
										type: "object"
									}
								}
								type: "object"
							}
							alerting: {
								properties: alertmanagers: {
									items: {
										properties: {
											apiVersion: type: "string"
											authorization: {
												properties: {
													credentials: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													type: type: "string"
												}
												type: "object"
											}
											basicAuth: {
												properties: {
													password: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													username: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											bearerTokenFile: type: "string"
											enableHttp2: type: "boolean"
											name: type: "string"
											namespace: type: "string"
											pathPrefix: type: "string"
											port: {
												anyOf: [{
													type: "integer"
												}, {
													type: "string"
												}]
												"x-kubernetes-int-or-string": true
											}
											scheme: type: "string"
											sigv4: {
												properties: {
													accessKey: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													profile: type: "string"
													region: type: "string"
													roleArn: type: "string"
													secretKey: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											timeout: {
												pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
												type:    "string"
											}
											tlsConfig: {
												properties: {
													ca: {
														properties: {
															configMap: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															secret: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
														}
														type: "object"
													}
													caFile: type: "string"
													cert: {
														properties: {
															configMap: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															secret: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
														}
														type: "object"
													}
													certFile: type: "string"
													insecureSkipVerify: type: "boolean"
													keyFile: type: "string"
													keySecret: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													serverName: type: "string"
												}
												type: "object"
											}
										}
										required: [
											"name",
											"namespace",
											"port",
										]
										type: "object"
									}
									type: "array"
								}
								required: [
									"alertmanagers",
								]
								type: "object"
							}
							allowOverlappingBlocks: type: "boolean"
							apiserverConfig: {
								properties: {
									authorization: {
										properties: {
											credentials: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											credentialsFile: type: "string"
											type: type: "string"
										}
										type: "object"
									}
									basicAuth: {
										properties: {
											password: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											username: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
										}
										type: "object"
									}
									bearerToken: type: "string"
									bearerTokenFile: type: "string"
									host: type: "string"
									tlsConfig: {
										properties: {
											ca: {
												properties: {
													configMap: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													secret: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											caFile: type: "string"
											cert: {
												properties: {
													configMap: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													secret: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											certFile: type: "string"
											insecureSkipVerify: type: "boolean"
											keyFile: type: "string"
											keySecret: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											serverName: type: "string"
										}
										type: "object"
									}
								}
								required: [
									"host",
								]
								type: "object"
							}
							arbitraryFSAccessThroughSMs: {
								properties: deny: type: "boolean"
								type: "object"
							}
							baseImage: type: "string"
							bodySizeLimit: {
								pattern: "(^0|([0-9]*[.])?[0-9]+((K|M|G|T|E|P)i?)?B)$"
								type:    "string"
							}
							configMaps: {
								items: type: "string"
								type: "array"
							}
							containers: {
								items: {
									properties: {
										args: {
											items: type: "string"
											type: "array"
										}
										command: {
											items: type: "string"
											type: "array"
										}
										env: {
											items: {
												properties: {
													name: type: "string"
													value: type: "string"
													valueFrom: {
														properties: {
															configMapKeyRef: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															fieldRef: {
																properties: {
																	apiVersion: type: "string"
																	fieldPath: type: "string"
																}
																required: [
																	"fieldPath",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															resourceFieldRef: {
																properties: {
																	containerName: type: "string"
																	divisor: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	resource: type: "string"
																}
																required: [
																	"resource",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															secretKeyRef: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
														}
														type: "object"
													}
												}
												required: [
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										envFrom: {
											items: {
												properties: {
													configMapRef: {
														properties: {
															name: type: "string"
															optional: type: "boolean"
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													prefix: type: "string"
													secretRef: {
														properties: {
															name: type: "string"
															optional: type: "boolean"
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											type: "array"
										}
										image: type: "string"
										imagePullPolicy: type: "string"
										lifecycle: {
											properties: {
												postStart: {
													properties: {
														exec: {
															properties: command: {
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														httpGet: {
															properties: {
																host: type: "string"
																httpHeaders: {
																	items: {
																		properties: {
																			name: type: "string"
																			value: type: "string"
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																path: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
																scheme: type: "string"
															}
															required: [
																"port",
															]
															type: "object"
														}
														sleep: {
															properties: seconds: {
																format: "int64"
																type:   "integer"
															}
															required: [
																"seconds",
															]
															type: "object"
														}
														tcpSocket: {
															properties: {
																host: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
															}
															required: [
																"port",
															]
															type: "object"
														}
													}
													type: "object"
												}
												preStop: {
													properties: {
														exec: {
															properties: command: {
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														httpGet: {
															properties: {
																host: type: "string"
																httpHeaders: {
																	items: {
																		properties: {
																			name: type: "string"
																			value: type: "string"
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																path: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
																scheme: type: "string"
															}
															required: [
																"port",
															]
															type: "object"
														}
														sleep: {
															properties: seconds: {
																format: "int64"
																type:   "integer"
															}
															required: [
																"seconds",
															]
															type: "object"
														}
														tcpSocket: {
															properties: {
																host: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
															}
															required: [
																"port",
															]
															type: "object"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										livenessProbe: {
											properties: {
												exec: {
													properties: command: {
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													format: "int32"
													type:   "integer"
												}
												grpc: {
													properties: {
														port: {
															format: "int32"
															type:   "integer"
														}
														service: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												httpGet: {
													properties: {
														host: type: "string"
														httpHeaders: {
															items: {
																properties: {
																	name: type: "string"
																	value: type: "string"
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
														scheme: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												initialDelaySeconds: {
													format: "int32"
													type:   "integer"
												}
												periodSeconds: {
													format: "int32"
													type:   "integer"
												}
												successThreshold: {
													format: "int32"
													type:   "integer"
												}
												tcpSocket: {
													properties: {
														host: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
													}
													required: [
														"port",
													]
													type: "object"
												}
												terminationGracePeriodSeconds: {
													format: "int64"
													type:   "integer"
												}
												timeoutSeconds: {
													format: "int32"
													type:   "integer"
												}
											}
											type: "object"
										}
										name: type: "string"
										ports: {
											items: {
												properties: {
													containerPort: {
														format: "int32"
														type:   "integer"
													}
													hostIP: type: "string"
													hostPort: {
														format: "int32"
														type:   "integer"
													}
													name: type: "string"
													protocol: {
														default: "TCP"
														type:    "string"
													}
												}
												required: [
													"containerPort",
												]
												type: "object"
											}
											type: "array"
											"x-kubernetes-list-map-keys": [
												"containerPort",
												"protocol",
											]
											"x-kubernetes-list-type": "map"
										}
										readinessProbe: {
											properties: {
												exec: {
													properties: command: {
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													format: "int32"
													type:   "integer"
												}
												grpc: {
													properties: {
														port: {
															format: "int32"
															type:   "integer"
														}
														service: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												httpGet: {
													properties: {
														host: type: "string"
														httpHeaders: {
															items: {
																properties: {
																	name: type: "string"
																	value: type: "string"
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
														scheme: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												initialDelaySeconds: {
													format: "int32"
													type:   "integer"
												}
												periodSeconds: {
													format: "int32"
													type:   "integer"
												}
												successThreshold: {
													format: "int32"
													type:   "integer"
												}
												tcpSocket: {
													properties: {
														host: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
													}
													required: [
														"port",
													]
													type: "object"
												}
												terminationGracePeriodSeconds: {
													format: "int64"
													type:   "integer"
												}
												timeoutSeconds: {
													format: "int32"
													type:   "integer"
												}
											}
											type: "object"
										}
										resizePolicy: {
											items: {
												properties: {
													resourceName: type: "string"
													restartPolicy: type: "string"
												}
												required: [
													"resourceName",
													"restartPolicy",
												]
												type: "object"
											}
											type:                     "array"
											"x-kubernetes-list-type": "atomic"
										}
										resources: {
											properties: {
												claims: {
													items: {
														properties: name: type: "string"
														required: [
															"name",
														]
														type: "object"
													}
													type: "array"
													"x-kubernetes-list-map-keys": [
														"name",
													]
													"x-kubernetes-list-type": "map"
												}
												limits: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													type: "object"
												}
												requests: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													type: "object"
												}
											}
											type: "object"
										}
										restartPolicy: type: "string"
										securityContext: {
											properties: {
												allowPrivilegeEscalation: type: "boolean"
												capabilities: {
													properties: {
														add: {
															items: type: "string"
															type: "array"
														}
														drop: {
															items: type: "string"
															type: "array"
														}
													}
													type: "object"
												}
												privileged: type: "boolean"
												procMount: type: "string"
												readOnlyRootFilesystem: type: "boolean"
												runAsGroup: {
													format: "int64"
													type:   "integer"
												}
												runAsNonRoot: type: "boolean"
												runAsUser: {
													format: "int64"
													type:   "integer"
												}
												seLinuxOptions: {
													properties: {
														level: type: "string"
														role: type: "string"
														type: type: "string"
														user: type: "string"
													}
													type: "object"
												}
												seccompProfile: {
													properties: {
														localhostProfile: type: "string"
														type: type: "string"
													}
													required: [
														"type",
													]
													type: "object"
												}
												windowsOptions: {
													properties: {
														gmsaCredentialSpec: type: "string"
														gmsaCredentialSpecName: type: "string"
														hostProcess: type: "boolean"
														runAsUserName: type: "string"
													}
													type: "object"
												}
											}
											type: "object"
										}
										startupProbe: {
											properties: {
												exec: {
													properties: command: {
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													format: "int32"
													type:   "integer"
												}
												grpc: {
													properties: {
														port: {
															format: "int32"
															type:   "integer"
														}
														service: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												httpGet: {
													properties: {
														host: type: "string"
														httpHeaders: {
															items: {
																properties: {
																	name: type: "string"
																	value: type: "string"
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
														scheme: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												initialDelaySeconds: {
													format: "int32"
													type:   "integer"
												}
												periodSeconds: {
													format: "int32"
													type:   "integer"
												}
												successThreshold: {
													format: "int32"
													type:   "integer"
												}
												tcpSocket: {
													properties: {
														host: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
													}
													required: [
														"port",
													]
													type: "object"
												}
												terminationGracePeriodSeconds: {
													format: "int64"
													type:   "integer"
												}
												timeoutSeconds: {
													format: "int32"
													type:   "integer"
												}
											}
											type: "object"
										}
										stdin: type: "boolean"
										stdinOnce: type: "boolean"
										terminationMessagePath: type: "string"
										terminationMessagePolicy: type: "string"
										tty: type: "boolean"
										volumeDevices: {
											items: {
												properties: {
													devicePath: type: "string"
													name: type: "string"
												}
												required: [
													"devicePath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										volumeMounts: {
											items: {
												properties: {
													mountPath: type: "string"
													mountPropagation: type: "string"
													name: type: "string"
													readOnly: type: "boolean"
													subPath: type: "string"
													subPathExpr: type: "string"
												}
												required: [
													"mountPath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										workingDir: type: "string"
									}
									required: [
										"name",
									]
									type: "object"
								}
								type: "array"
							}
							disableCompaction: type: "boolean"
							enableAdminAPI: type: "boolean"
							enableFeatures: {
								items: type: "string"
								type: "array"
							}
							enableRemoteWriteReceiver: type: "boolean"
							enforcedBodySizeLimit: {
								pattern: "(^0|([0-9]*[.])?[0-9]+((K|M|G|T|E|P)i?)?B)$"
								type:    "string"
							}
							enforcedKeepDroppedTargets: {
								format: "int64"
								type:   "integer"
							}
							enforcedLabelLimit: {
								format: "int64"
								type:   "integer"
							}
							enforcedLabelNameLengthLimit: {
								format: "int64"
								type:   "integer"
							}
							enforcedLabelValueLengthLimit: {
								format: "int64"
								type:   "integer"
							}
							enforcedNamespaceLabel: type: "string"
							enforcedSampleLimit: {
								format: "int64"
								type:   "integer"
							}
							enforcedTargetLimit: {
								format: "int64"
								type:   "integer"
							}
							evaluationInterval: {
								default: "30s"
								pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
								type:    "string"
							}
							excludedFromEnforcement: {
								items: {
									properties: {
										group: {
											default: "monitoring.coreos.com"
											enum: [
												"monitoring.coreos.com",
											]
											type: "string"
										}
										name: type: "string"
										namespace: {
											minLength: 1
											type:      "string"
										}
										resource: {
											enum: [
												"prometheusrules",
												"servicemonitors",
												"podmonitors",
												"probes",
												"scrapeconfigs",
											]
											type: "string"
										}
									}
									required: [
										"namespace",
										"resource",
									]
									type: "object"
								}
								type: "array"
							}
							exemplars: {
								properties: maxSize: {
									format: "int64"
									type:   "integer"
								}
								type: "object"
							}
							externalLabels: {
								additionalProperties: type: "string"
								type: "object"
							}
							externalUrl: type: "string"
							hostAliases: {
								items: {
									properties: {
										hostnames: {
											items: type: "string"
											type: "array"
										}
										ip: type: "string"
									}
									required: [
										"hostnames",
										"ip",
									]
									type: "object"
								}
								type: "array"
								"x-kubernetes-list-map-keys": [
									"ip",
								]
								"x-kubernetes-list-type": "map"
							}
							hostNetwork: type: "boolean"
							ignoreNamespaceSelectors: type: "boolean"
							image: type: "string"
							imagePullPolicy: {
								enum: [
									"",
									"Always",
									"Never",
									"IfNotPresent",
								]
								type: "string"
							}
							imagePullSecrets: {
								items: {
									properties: name: type: "string"
									type:                    "object"
									"x-kubernetes-map-type": "atomic"
								}
								type: "array"
							}
							initContainers: {
								items: {
									properties: {
										args: {
											items: type: "string"
											type: "array"
										}
										command: {
											items: type: "string"
											type: "array"
										}
										env: {
											items: {
												properties: {
													name: type: "string"
													value: type: "string"
													valueFrom: {
														properties: {
															configMapKeyRef: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															fieldRef: {
																properties: {
																	apiVersion: type: "string"
																	fieldPath: type: "string"
																}
																required: [
																	"fieldPath",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															resourceFieldRef: {
																properties: {
																	containerName: type: "string"
																	divisor: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	resource: type: "string"
																}
																required: [
																	"resource",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															secretKeyRef: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
														}
														type: "object"
													}
												}
												required: [
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										envFrom: {
											items: {
												properties: {
													configMapRef: {
														properties: {
															name: type: "string"
															optional: type: "boolean"
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													prefix: type: "string"
													secretRef: {
														properties: {
															name: type: "string"
															optional: type: "boolean"
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											type: "array"
										}
										image: type: "string"
										imagePullPolicy: type: "string"
										lifecycle: {
											properties: {
												postStart: {
													properties: {
														exec: {
															properties: command: {
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														httpGet: {
															properties: {
																host: type: "string"
																httpHeaders: {
																	items: {
																		properties: {
																			name: type: "string"
																			value: type: "string"
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																path: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
																scheme: type: "string"
															}
															required: [
																"port",
															]
															type: "object"
														}
														sleep: {
															properties: seconds: {
																format: "int64"
																type:   "integer"
															}
															required: [
																"seconds",
															]
															type: "object"
														}
														tcpSocket: {
															properties: {
																host: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
															}
															required: [
																"port",
															]
															type: "object"
														}
													}
													type: "object"
												}
												preStop: {
													properties: {
														exec: {
															properties: command: {
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														httpGet: {
															properties: {
																host: type: "string"
																httpHeaders: {
																	items: {
																		properties: {
																			name: type: "string"
																			value: type: "string"
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																path: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
																scheme: type: "string"
															}
															required: [
																"port",
															]
															type: "object"
														}
														sleep: {
															properties: seconds: {
																format: "int64"
																type:   "integer"
															}
															required: [
																"seconds",
															]
															type: "object"
														}
														tcpSocket: {
															properties: {
																host: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
															}
															required: [
																"port",
															]
															type: "object"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										livenessProbe: {
											properties: {
												exec: {
													properties: command: {
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													format: "int32"
													type:   "integer"
												}
												grpc: {
													properties: {
														port: {
															format: "int32"
															type:   "integer"
														}
														service: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												httpGet: {
													properties: {
														host: type: "string"
														httpHeaders: {
															items: {
																properties: {
																	name: type: "string"
																	value: type: "string"
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
														scheme: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												initialDelaySeconds: {
													format: "int32"
													type:   "integer"
												}
												periodSeconds: {
													format: "int32"
													type:   "integer"
												}
												successThreshold: {
													format: "int32"
													type:   "integer"
												}
												tcpSocket: {
													properties: {
														host: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
													}
													required: [
														"port",
													]
													type: "object"
												}
												terminationGracePeriodSeconds: {
													format: "int64"
													type:   "integer"
												}
												timeoutSeconds: {
													format: "int32"
													type:   "integer"
												}
											}
											type: "object"
										}
										name: type: "string"
										ports: {
											items: {
												properties: {
													containerPort: {
														format: "int32"
														type:   "integer"
													}
													hostIP: type: "string"
													hostPort: {
														format: "int32"
														type:   "integer"
													}
													name: type: "string"
													protocol: {
														default: "TCP"
														type:    "string"
													}
												}
												required: [
													"containerPort",
												]
												type: "object"
											}
											type: "array"
											"x-kubernetes-list-map-keys": [
												"containerPort",
												"protocol",
											]
											"x-kubernetes-list-type": "map"
										}
										readinessProbe: {
											properties: {
												exec: {
													properties: command: {
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													format: "int32"
													type:   "integer"
												}
												grpc: {
													properties: {
														port: {
															format: "int32"
															type:   "integer"
														}
														service: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												httpGet: {
													properties: {
														host: type: "string"
														httpHeaders: {
															items: {
																properties: {
																	name: type: "string"
																	value: type: "string"
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
														scheme: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												initialDelaySeconds: {
													format: "int32"
													type:   "integer"
												}
												periodSeconds: {
													format: "int32"
													type:   "integer"
												}
												successThreshold: {
													format: "int32"
													type:   "integer"
												}
												tcpSocket: {
													properties: {
														host: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
													}
													required: [
														"port",
													]
													type: "object"
												}
												terminationGracePeriodSeconds: {
													format: "int64"
													type:   "integer"
												}
												timeoutSeconds: {
													format: "int32"
													type:   "integer"
												}
											}
											type: "object"
										}
										resizePolicy: {
											items: {
												properties: {
													resourceName: type: "string"
													restartPolicy: type: "string"
												}
												required: [
													"resourceName",
													"restartPolicy",
												]
												type: "object"
											}
											type:                     "array"
											"x-kubernetes-list-type": "atomic"
										}
										resources: {
											properties: {
												claims: {
													items: {
														properties: name: type: "string"
														required: [
															"name",
														]
														type: "object"
													}
													type: "array"
													"x-kubernetes-list-map-keys": [
														"name",
													]
													"x-kubernetes-list-type": "map"
												}
												limits: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													type: "object"
												}
												requests: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													type: "object"
												}
											}
											type: "object"
										}
										restartPolicy: type: "string"
										securityContext: {
											properties: {
												allowPrivilegeEscalation: type: "boolean"
												capabilities: {
													properties: {
														add: {
															items: type: "string"
															type: "array"
														}
														drop: {
															items: type: "string"
															type: "array"
														}
													}
													type: "object"
												}
												privileged: type: "boolean"
												procMount: type: "string"
												readOnlyRootFilesystem: type: "boolean"
												runAsGroup: {
													format: "int64"
													type:   "integer"
												}
												runAsNonRoot: type: "boolean"
												runAsUser: {
													format: "int64"
													type:   "integer"
												}
												seLinuxOptions: {
													properties: {
														level: type: "string"
														role: type: "string"
														type: type: "string"
														user: type: "string"
													}
													type: "object"
												}
												seccompProfile: {
													properties: {
														localhostProfile: type: "string"
														type: type: "string"
													}
													required: [
														"type",
													]
													type: "object"
												}
												windowsOptions: {
													properties: {
														gmsaCredentialSpec: type: "string"
														gmsaCredentialSpecName: type: "string"
														hostProcess: type: "boolean"
														runAsUserName: type: "string"
													}
													type: "object"
												}
											}
											type: "object"
										}
										startupProbe: {
											properties: {
												exec: {
													properties: command: {
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													format: "int32"
													type:   "integer"
												}
												grpc: {
													properties: {
														port: {
															format: "int32"
															type:   "integer"
														}
														service: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												httpGet: {
													properties: {
														host: type: "string"
														httpHeaders: {
															items: {
																properties: {
																	name: type: "string"
																	value: type: "string"
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
														scheme: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												initialDelaySeconds: {
													format: "int32"
													type:   "integer"
												}
												periodSeconds: {
													format: "int32"
													type:   "integer"
												}
												successThreshold: {
													format: "int32"
													type:   "integer"
												}
												tcpSocket: {
													properties: {
														host: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
													}
													required: [
														"port",
													]
													type: "object"
												}
												terminationGracePeriodSeconds: {
													format: "int64"
													type:   "integer"
												}
												timeoutSeconds: {
													format: "int32"
													type:   "integer"
												}
											}
											type: "object"
										}
										stdin: type: "boolean"
										stdinOnce: type: "boolean"
										terminationMessagePath: type: "string"
										terminationMessagePolicy: type: "string"
										tty: type: "boolean"
										volumeDevices: {
											items: {
												properties: {
													devicePath: type: "string"
													name: type: "string"
												}
												required: [
													"devicePath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										volumeMounts: {
											items: {
												properties: {
													mountPath: type: "string"
													mountPropagation: type: "string"
													name: type: "string"
													readOnly: type: "boolean"
													subPath: type: "string"
													subPathExpr: type: "string"
												}
												required: [
													"mountPath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										workingDir: type: "string"
									}
									required: [
										"name",
									]
									type: "object"
								}
								type: "array"
							}
							keepDroppedTargets: {
								format: "int64"
								type:   "integer"
							}
							labelLimit: {
								format: "int64"
								type:   "integer"
							}
							labelNameLengthLimit: {
								format: "int64"
								type:   "integer"
							}
							labelValueLengthLimit: {
								format: "int64"
								type:   "integer"
							}
							listenLocal: type: "boolean"
							logFormat: {
								enum: [
									"",
									"logfmt",
									"json",
								]
								type: "string"
							}
							logLevel: {
								enum: [
									"",
									"debug",
									"info",
									"warn",
									"error",
								]
								type: "string"
							}
							maximumStartupDurationSeconds: {
								format:  "int32"
								minimum: 60
								type:    "integer"
							}
							minReadySeconds: {
								format: "int32"
								type:   "integer"
							}
							nodeSelector: {
								additionalProperties: type: "string"
								type: "object"
							}
							overrideHonorLabels: type: "boolean"
							overrideHonorTimestamps: type: "boolean"
							paused: type: "boolean"
							persistentVolumeClaimRetentionPolicy: {
								properties: {
									whenDeleted: type: "string"
									whenScaled: type: "string"
								}
								type: "object"
							}
							podMetadata: {
								properties: {
									annotations: {
										additionalProperties: type: "string"
										type: "object"
									}
									labels: {
										additionalProperties: type: "string"
										type: "object"
									}
									name: type: "string"
								}
								type: "object"
							}
							podMonitorNamespaceSelector: {
								properties: {
									matchExpressions: {
										items: {
											properties: {
												key: type: "string"
												operator: type: "string"
												values: {
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							podMonitorSelector: {
								properties: {
									matchExpressions: {
										items: {
											properties: {
												key: type: "string"
												operator: type: "string"
												values: {
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							podTargetLabels: {
								items: type: "string"
								type: "array"
							}
							portName: {
								default: "web"
								type:    "string"
							}
							priorityClassName: type: "string"
							probeNamespaceSelector: {
								properties: {
									matchExpressions: {
										items: {
											properties: {
												key: type: "string"
												operator: type: "string"
												values: {
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							probeSelector: {
								properties: {
									matchExpressions: {
										items: {
											properties: {
												key: type: "string"
												operator: type: "string"
												values: {
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							prometheusExternalLabelName: type: "string"
							prometheusRulesExcludedFromEnforce: {
								items: {
									properties: {
										ruleName: type: "string"
										ruleNamespace: type: "string"
									}
									required: [
										"ruleName",
										"ruleNamespace",
									]
									type: "object"
								}
								type: "array"
							}
							query: {
								properties: {
									lookbackDelta: type: "string"
									maxConcurrency: {
										format:  "int32"
										minimum: 1
										type:    "integer"
									}
									maxSamples: {
										format: "int32"
										type:   "integer"
									}
									timeout: {
										pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
										type:    "string"
									}
								}
								type: "object"
							}
							queryLogFile: type: "string"
							reloadStrategy: {
								enum: [
									"HTTP",
									"ProcessSignal",
								]
								type: "string"
							}
							remoteRead: {
								items: {
									properties: {
										authorization: {
											properties: {
												credentials: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												credentialsFile: type: "string"
												type: type: "string"
											}
											type: "object"
										}
										basicAuth: {
											properties: {
												password: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												username: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
											}
											type: "object"
										}
										bearerToken: type: "string"
										bearerTokenFile: type: "string"
										filterExternalLabels: type: "boolean"
										followRedirects: type: "boolean"
										headers: {
											additionalProperties: type: "string"
											type: "object"
										}
										name: type: "string"
										oauth2: {
											properties: {
												clientId: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												clientSecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												endpointParams: {
													additionalProperties: type: "string"
													type: "object"
												}
												scopes: {
													items: type: "string"
													type: "array"
												}
												tokenUrl: {
													minLength: 1
													type:      "string"
												}
											}
											required: [
												"clientId",
												"clientSecret",
												"tokenUrl",
											]
											type: "object"
										}
										proxyUrl: type: "string"
										readRecent: type: "boolean"
										remoteTimeout: {
											pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
											type:    "string"
										}
										requiredMatchers: {
											additionalProperties: type: "string"
											type: "object"
										}
										tlsConfig: {
											properties: {
												ca: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												caFile: type: "string"
												cert: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												certFile: type: "string"
												insecureSkipVerify: type: "boolean"
												keyFile: type: "string"
												keySecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												serverName: type: "string"
											}
											type: "object"
										}
										url: type: "string"
									}
									required: [
										"url",
									]
									type: "object"
								}
								type: "array"
							}
							remoteWrite: {
								items: {
									properties: {
										authorization: {
											properties: {
												credentials: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												credentialsFile: type: "string"
												type: type: "string"
											}
											type: "object"
										}
										azureAd: {
											properties: {
												cloud: {
													enum: [
														"AzureChina",
														"AzureGovernment",
														"AzurePublic",
													]
													type: "string"
												}
												managedIdentity: {
													properties: clientId: type: "string"
													required: [
														"clientId",
													]
													type: "object"
												}
												oauth: {
													properties: {
														clientId: {
															minLength: 1
															type:      "string"
														}
														clientSecret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														tenantId: {
															minLength: 1
															pattern:   "^[0-9a-zA-Z-.]+$"
															type:      "string"
														}
													}
													required: [
														"clientId",
														"clientSecret",
														"tenantId",
													]
													type: "object"
												}
											}
											type: "object"
										}
										basicAuth: {
											properties: {
												password: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												username: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
											}
											type: "object"
										}
										bearerToken: type: "string"
										bearerTokenFile: type: "string"
										enableHTTP2: type: "boolean"
										headers: {
											additionalProperties: type: "string"
											type: "object"
										}
										metadataConfig: {
											properties: {
												send: type: "boolean"
												sendInterval: {
													pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
													type:    "string"
												}
											}
											type: "object"
										}
										name: type: "string"
										oauth2: {
											properties: {
												clientId: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												clientSecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												endpointParams: {
													additionalProperties: type: "string"
													type: "object"
												}
												scopes: {
													items: type: "string"
													type: "array"
												}
												tokenUrl: {
													minLength: 1
													type:      "string"
												}
											}
											required: [
												"clientId",
												"clientSecret",
												"tokenUrl",
											]
											type: "object"
										}
										proxyUrl: type: "string"
										queueConfig: {
											properties: {
												batchSendDeadline: type: "string"
												capacity: type: "integer"
												maxBackoff: type: "string"
												maxRetries: type: "integer"
												maxSamplesPerSend: type: "integer"
												maxShards: type: "integer"
												minBackoff: type: "string"
												minShards: type: "integer"
												retryOnRateLimit: type: "boolean"
											}
											type: "object"
										}
										remoteTimeout: {
											pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
											type:    "string"
										}
										sendExemplars: type: "boolean"
										sendNativeHistograms: type: "boolean"
										sigv4: {
											properties: {
												accessKey: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												profile: type: "string"
												region: type: "string"
												roleArn: type: "string"
												secretKey: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
											}
											type: "object"
										}
										tlsConfig: {
											properties: {
												ca: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												caFile: type: "string"
												cert: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												certFile: type: "string"
												insecureSkipVerify: type: "boolean"
												keyFile: type: "string"
												keySecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												serverName: type: "string"
											}
											type: "object"
										}
										url: type: "string"
										writeRelabelConfigs: {
											items: {
												properties: {
													action: {
														default: "replace"
														enum: [
															"replace",
															"Replace",
															"keep",
															"Keep",
															"drop",
															"Drop",
															"hashmod",
															"HashMod",
															"labelmap",
															"LabelMap",
															"labeldrop",
															"LabelDrop",
															"labelkeep",
															"LabelKeep",
															"lowercase",
															"Lowercase",
															"uppercase",
															"Uppercase",
															"keepequal",
															"KeepEqual",
															"dropequal",
															"DropEqual",
														]
														type: "string"
													}
													modulus: {
														format: "int64"
														type:   "integer"
													}
													regex: type: "string"
													replacement: type: "string"
													separator: type: "string"
													sourceLabels: {
														items: {
															pattern: "^[a-zA-Z_][a-zA-Z0-9_]*$"
															type:    "string"
														}
														type: "array"
													}
													targetLabel: type: "string"
												}
												type: "object"
											}
											type: "array"
										}
									}
									required: [
										"url",
									]
									type: "object"
								}
								type: "array"
							}
							replicaExternalLabelName: type: "string"
							replicas: {
								format: "int32"
								type:   "integer"
							}
							resources: {
								properties: {
									claims: {
										items: {
											properties: name: type: "string"
											required: [
												"name",
											]
											type: "object"
										}
										type: "array"
										"x-kubernetes-list-map-keys": [
											"name",
										]
										"x-kubernetes-list-type": "map"
									}
									limits: {
										additionalProperties: {
											anyOf: [{
												type: "integer"
											}, {
												type: "string"
											}]
											pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
											"x-kubernetes-int-or-string": true
										}
										type: "object"
									}
									requests: {
										additionalProperties: {
											anyOf: [{
												type: "integer"
											}, {
												type: "string"
											}]
											pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
											"x-kubernetes-int-or-string": true
										}
										type: "object"
									}
								}
								type: "object"
							}
							retention: {
								pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
								type:    "string"
							}
							retentionSize: {
								pattern: "(^0|([0-9]*[.])?[0-9]+((K|M|G|T|E|P)i?)?B)$"
								type:    "string"
							}
							routePrefix: type: "string"
							ruleNamespaceSelector: {
								properties: {
									matchExpressions: {
										items: {
											properties: {
												key: type: "string"
												operator: type: "string"
												values: {
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							ruleSelector: {
								properties: {
									matchExpressions: {
										items: {
											properties: {
												key: type: "string"
												operator: type: "string"
												values: {
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							rules: {
								properties: alert: {
									properties: {
										forGracePeriod: type: "string"
										forOutageTolerance: type: "string"
										resendDelay: type: "string"
									}
									type: "object"
								}
								type: "object"
							}
							sampleLimit: {
								format: "int64"
								type:   "integer"
							}
							scrapeClasses: {
								items: {
									properties: {
										default: type: "boolean"
										name: {
											minLength: 1
											type:      "string"
										}
										tlsConfig: {
											properties: {
												ca: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												caFile: type: "string"
												cert: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												certFile: type: "string"
												insecureSkipVerify: type: "boolean"
												keyFile: type: "string"
												keySecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												serverName: type: "string"
											}
											type: "object"
										}
									}
									required: [
										"name",
									]
									type: "object"
								}
								type: "array"
								"x-kubernetes-list-map-keys": [
									"name",
								]
								"x-kubernetes-list-type": "map"
							}
							scrapeConfigNamespaceSelector: {
								properties: {
									matchExpressions: {
										items: {
											properties: {
												key: type: "string"
												operator: type: "string"
												values: {
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							scrapeConfigSelector: {
								properties: {
									matchExpressions: {
										items: {
											properties: {
												key: type: "string"
												operator: type: "string"
												values: {
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							scrapeInterval: {
								default: "30s"
								pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
								type:    "string"
							}
							scrapeProtocols: {
								items: {
									enum: [
										"PrometheusProto",
										"OpenMetricsText0.0.1",
										"OpenMetricsText1.0.0",
										"PrometheusText0.0.4",
									]
									type: "string"
								}
								type:                     "array"
								"x-kubernetes-list-type": "set"
							}
							scrapeTimeout: {
								pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
								type:    "string"
							}
							secrets: {
								items: type: "string"
								type: "array"
							}
							securityContext: {
								properties: {
									fsGroup: {
										format: "int64"
										type:   "integer"
									}
									fsGroupChangePolicy: type: "string"
									runAsGroup: {
										format: "int64"
										type:   "integer"
									}
									runAsNonRoot: type: "boolean"
									runAsUser: {
										format: "int64"
										type:   "integer"
									}
									seLinuxOptions: {
										properties: {
											level: type: "string"
											role: type: "string"
											type: type: "string"
											user: type: "string"
										}
										type: "object"
									}
									seccompProfile: {
										properties: {
											localhostProfile: type: "string"
											type: type: "string"
										}
										required: [
											"type",
										]
										type: "object"
									}
									supplementalGroups: {
										items: {
											format: "int64"
											type:   "integer"
										}
										type: "array"
									}
									sysctls: {
										items: {
											properties: {
												name: type: "string"
												value: type: "string"
											}
											required: [
												"name",
												"value",
											]
											type: "object"
										}
										type: "array"
									}
									windowsOptions: {
										properties: {
											gmsaCredentialSpec: type: "string"
											gmsaCredentialSpecName: type: "string"
											hostProcess: type: "boolean"
											runAsUserName: type: "string"
										}
										type: "object"
									}
								}
								type: "object"
							}
							serviceAccountName: type: "string"
							serviceMonitorNamespaceSelector: {
								properties: {
									matchExpressions: {
										items: {
											properties: {
												key: type: "string"
												operator: type: "string"
												values: {
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							serviceMonitorSelector: {
								properties: {
									matchExpressions: {
										items: {
											properties: {
												key: type: "string"
												operator: type: "string"
												values: {
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							sha: type: "string"
							shards: {
								format: "int32"
								type:   "integer"
							}
							storage: {
								properties: {
									disableMountSubPath: type: "boolean"
									emptyDir: {
										properties: {
											medium: type: "string"
											sizeLimit: {
												anyOf: [{
													type: "integer"
												}, {
													type: "string"
												}]
												pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
												"x-kubernetes-int-or-string": true
											}
										}
										type: "object"
									}
									ephemeral: {
										properties: volumeClaimTemplate: {
											properties: {
												metadata: type: "object"
												spec: {
													properties: {
														accessModes: {
															items: type: "string"
															type: "array"
														}
														dataSource: {
															properties: {
																apiGroup: type: "string"
																kind: type: "string"
																name: type: "string"
															}
															required: [
																"kind",
																"name",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														dataSourceRef: {
															properties: {
																apiGroup: type: "string"
																kind: type: "string"
																name: type: "string"
																namespace: type: "string"
															}
															required: [
																"kind",
																"name",
															]
															type: "object"
														}
														resources: {
															properties: {
																limits: {
																	additionalProperties: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	type: "object"
																}
																requests: {
																	additionalProperties: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	type: "object"
																}
															}
															type: "object"
														}
														selector: {
															properties: {
																matchExpressions: {
																	items: {
																		properties: {
																			key: type: "string"
																			operator: type: "string"
																			values: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														storageClassName: type: "string"
														volumeAttributesClassName: type: "string"
														volumeMode: type: "string"
														volumeName: type: "string"
													}
													type: "object"
												}
											}
											required: [
												"spec",
											]
											type: "object"
										}
										type: "object"
									}
									volumeClaimTemplate: {
										properties: {
											apiVersion: type: "string"
											kind: type: "string"
											metadata: {
												properties: {
													annotations: {
														additionalProperties: type: "string"
														type: "object"
													}
													labels: {
														additionalProperties: type: "string"
														type: "object"
													}
													name: type: "string"
												}
												type: "object"
											}
											spec: {
												properties: {
													accessModes: {
														items: type: "string"
														type: "array"
													}
													dataSource: {
														properties: {
															apiGroup: type: "string"
															kind: type: "string"
															name: type: "string"
														}
														required: [
															"kind",
															"name",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													dataSourceRef: {
														properties: {
															apiGroup: type: "string"
															kind: type: "string"
															name: type: "string"
															namespace: type: "string"
														}
														required: [
															"kind",
															"name",
														]
														type: "object"
													}
													resources: {
														properties: {
															limits: {
																additionalProperties: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																	"x-kubernetes-int-or-string": true
																}
																type: "object"
															}
															requests: {
																additionalProperties: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																	"x-kubernetes-int-or-string": true
																}
																type: "object"
															}
														}
														type: "object"
													}
													selector: {
														properties: {
															matchExpressions: {
																items: {
																	properties: {
																		key: type: "string"
																		operator: type: "string"
																		values: {
																			items: type: "string"
																			type: "array"
																		}
																	}
																	required: [
																		"key",
																		"operator",
																	]
																	type: "object"
																}
																type: "array"
															}
															matchLabels: {
																additionalProperties: type: "string"
																type: "object"
															}
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													storageClassName: type: "string"
													volumeAttributesClassName: type: "string"
													volumeMode: type: "string"
													volumeName: type: "string"
												}
												type: "object"
											}
											status: {
												properties: {
													accessModes: {
														items: type: "string"
														type: "array"
													}
													allocatedResourceStatuses: {
														additionalProperties: type: "string"
														type:                    "object"
														"x-kubernetes-map-type": "granular"
													}
													allocatedResources: {
														additionalProperties: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
															"x-kubernetes-int-or-string": true
														}
														type: "object"
													}
													capacity: {
														additionalProperties: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
															"x-kubernetes-int-or-string": true
														}
														type: "object"
													}
													conditions: {
														items: {
															properties: {
																lastProbeTime: {
																	format: "date-time"
																	type:   "string"
																}
																lastTransitionTime: {
																	format: "date-time"
																	type:   "string"
																}
																message: type: "string"
																reason: type: "string"
																status: type: "string"
																type: type: "string"
															}
															required: [
																"status",
																"type",
															]
															type: "object"
														}
														type: "array"
													}
													currentVolumeAttributesClassName: type: "string"
													modifyVolumeStatus: {
														properties: {
															status: type: "string"
															targetVolumeAttributesClassName: type: "string"
														}
														required: [
															"status",
														]
														type: "object"
													}
													phase: type: "string"
												}
												type: "object"
											}
										}
										type: "object"
									}
								}
								type: "object"
							}
							tag: type: "string"
							targetLimit: {
								format: "int64"
								type:   "integer"
							}
							thanos: {
								properties: {
									additionalArgs: {
										items: {
											properties: {
												name: {
													minLength: 1
													type:      "string"
												}
												value: type: "string"
											}
											required: [
												"name",
											]
											type: "object"
										}
										type: "array"
									}
									baseImage: type: "string"
									blockSize: {
										default: "2h"
										pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
										type:    "string"
									}
									getConfigInterval: {
										pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
										type:    "string"
									}
									getConfigTimeout: {
										pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
										type:    "string"
									}
									grpcListenLocal: type: "boolean"
									grpcServerTlsConfig: {
										properties: {
											ca: {
												properties: {
													configMap: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													secret: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											caFile: type: "string"
											cert: {
												properties: {
													configMap: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													secret: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											certFile: type: "string"
											insecureSkipVerify: type: "boolean"
											keyFile: type: "string"
											keySecret: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											serverName: type: "string"
										}
										type: "object"
									}
									httpListenLocal: type: "boolean"
									image: type: "string"
									listenLocal: type: "boolean"
									logFormat: {
										enum: [
											"",
											"logfmt",
											"json",
										]
										type: "string"
									}
									logLevel: {
										enum: [
											"",
											"debug",
											"info",
											"warn",
											"error",
										]
										type: "string"
									}
									minTime: type: "string"
									objectStorageConfig: {
										properties: {
											key: type: "string"
											name: type: "string"
											optional: type: "boolean"
										}
										required: [
											"key",
										]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
									objectStorageConfigFile: type: "string"
									readyTimeout: {
										pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
										type:    "string"
									}
									resources: {
										properties: {
											claims: {
												items: {
													properties: name: type: "string"
													required: [
														"name",
													]
													type: "object"
												}
												type: "array"
												"x-kubernetes-list-map-keys": [
													"name",
												]
												"x-kubernetes-list-type": "map"
											}
											limits: {
												additionalProperties: {
													anyOf: [{
														type: "integer"
													}, {
														type: "string"
													}]
													pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
													"x-kubernetes-int-or-string": true
												}
												type: "object"
											}
											requests: {
												additionalProperties: {
													anyOf: [{
														type: "integer"
													}, {
														type: "string"
													}]
													pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
													"x-kubernetes-int-or-string": true
												}
												type: "object"
											}
										}
										type: "object"
									}
									sha: type: "string"
									tag: type: "string"
									tracingConfig: {
										properties: {
											key: type: "string"
											name: type: "string"
											optional: type: "boolean"
										}
										required: [
											"key",
										]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
									tracingConfigFile: type: "string"
									version: type: "string"
									volumeMounts: {
										items: {
											properties: {
												mountPath: type: "string"
												mountPropagation: type: "string"
												name: type: "string"
												readOnly: type: "boolean"
												subPath: type: "string"
												subPathExpr: type: "string"
											}
											required: [
												"mountPath",
												"name",
											]
											type: "object"
										}
										type: "array"
									}
								}
								type: "object"
							}
							tolerations: {
								items: {
									properties: {
										effect: type: "string"
										key: type: "string"
										operator: type: "string"
										tolerationSeconds: {
											format: "int64"
											type:   "integer"
										}
										value: type: "string"
									}
									type: "object"
								}
								type: "array"
							}
							topologySpreadConstraints: {
								items: {
									properties: {
										additionalLabelSelectors: {
											enum: [
												"OnResource",
												"OnShard",
											]
											type: "string"
										}
										labelSelector: {
											properties: {
												matchExpressions: {
													items: {
														properties: {
															key: type: "string"
															operator: type: "string"
															values: {
																items: type: "string"
																type: "array"
															}
														}
														required: [
															"key",
															"operator",
														]
														type: "object"
													}
													type: "array"
												}
												matchLabels: {
													additionalProperties: type: "string"
													type: "object"
												}
											}
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										matchLabelKeys: {
											items: type: "string"
											type:                     "array"
											"x-kubernetes-list-type": "atomic"
										}
										maxSkew: {
											format: "int32"
											type:   "integer"
										}
										minDomains: {
											format: "int32"
											type:   "integer"
										}
										nodeAffinityPolicy: type: "string"
										nodeTaintsPolicy: type: "string"
										topologyKey: type: "string"
										whenUnsatisfiable: type: "string"
									}
									required: [
										"maxSkew",
										"topologyKey",
										"whenUnsatisfiable",
									]
									type: "object"
								}
								type: "array"
							}
							tracingConfig: {
								properties: {
									clientType: {
										enum: [
											"http",
											"grpc",
										]
										type: "string"
									}
									compression: {
										enum: [
											"gzip",
										]
										type: "string"
									}
									endpoint: {
										minLength: 1
										type:      "string"
									}
									headers: {
										additionalProperties: type: "string"
										type: "object"
									}
									insecure: type: "boolean"
									samplingFraction: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
										"x-kubernetes-int-or-string": true
									}
									timeout: {
										pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
										type:    "string"
									}
									tlsConfig: {
										properties: {
											ca: {
												properties: {
													configMap: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													secret: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											caFile: type: "string"
											cert: {
												properties: {
													configMap: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													secret: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											certFile: type: "string"
											insecureSkipVerify: type: "boolean"
											keyFile: type: "string"
											keySecret: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											serverName: type: "string"
										}
										type: "object"
									}
								}
								required: [
									"endpoint",
								]
								type: "object"
							}
							tsdb: {
								properties: outOfOrderTimeWindow: {
									pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
									type:    "string"
								}
								type: "object"
							}
							version: type: "string"
							volumeMounts: {
								items: {
									properties: {
										mountPath: type: "string"
										mountPropagation: type: "string"
										name: type: "string"
										readOnly: type: "boolean"
										subPath: type: "string"
										subPathExpr: type: "string"
									}
									required: [
										"mountPath",
										"name",
									]
									type: "object"
								}
								type: "array"
							}
							volumes: {
								items: {
									properties: {
										awsElasticBlockStore: {
											properties: {
												fsType: type: "string"
												partition: {
													format: "int32"
													type:   "integer"
												}
												readOnly: type: "boolean"
												volumeID: type: "string"
											}
											required: [
												"volumeID",
											]
											type: "object"
										}
										azureDisk: {
											properties: {
												cachingMode: type: "string"
												diskName: type: "string"
												diskURI: type: "string"
												fsType: type: "string"
												kind: type: "string"
												readOnly: type: "boolean"
											}
											required: [
												"diskName",
												"diskURI",
											]
											type: "object"
										}
										azureFile: {
											properties: {
												readOnly: type: "boolean"
												secretName: type: "string"
												shareName: type: "string"
											}
											required: [
												"secretName",
												"shareName",
											]
											type: "object"
										}
										cephfs: {
											properties: {
												monitors: {
													items: type: "string"
													type: "array"
												}
												path: type: "string"
												readOnly: type: "boolean"
												secretFile: type: "string"
												secretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												user: type: "string"
											}
											required: [
												"monitors",
											]
											type: "object"
										}
										cinder: {
											properties: {
												fsType: type: "string"
												readOnly: type: "boolean"
												secretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												volumeID: type: "string"
											}
											required: [
												"volumeID",
											]
											type: "object"
										}
										configMap: {
											properties: {
												defaultMode: {
													format: "int32"
													type:   "integer"
												}
												items: {
													items: {
														properties: {
															key: type: "string"
															mode: {
																format: "int32"
																type:   "integer"
															}
															path: type: "string"
														}
														required: [
															"key",
															"path",
														]
														type: "object"
													}
													type: "array"
												}
												name: type: "string"
												optional: type: "boolean"
											}
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										csi: {
											properties: {
												driver: type: "string"
												fsType: type: "string"
												nodePublishSecretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												readOnly: type: "boolean"
												volumeAttributes: {
													additionalProperties: type: "string"
													type: "object"
												}
											}
											required: [
												"driver",
											]
											type: "object"
										}
										downwardAPI: {
											properties: {
												defaultMode: {
													format: "int32"
													type:   "integer"
												}
												items: {
													items: {
														properties: {
															fieldRef: {
																properties: {
																	apiVersion: type: "string"
																	fieldPath: type: "string"
																}
																required: [
																	"fieldPath",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															mode: {
																format: "int32"
																type:   "integer"
															}
															path: type: "string"
															resourceFieldRef: {
																properties: {
																	containerName: type: "string"
																	divisor: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	resource: type: "string"
																}
																required: [
																	"resource",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
														}
														required: [
															"path",
														]
														type: "object"
													}
													type: "array"
												}
											}
											type: "object"
										}
										emptyDir: {
											properties: {
												medium: type: "string"
												sizeLimit: {
													anyOf: [{
														type: "integer"
													}, {
														type: "string"
													}]
													pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
													"x-kubernetes-int-or-string": true
												}
											}
											type: "object"
										}
										ephemeral: {
											properties: volumeClaimTemplate: {
												properties: {
													metadata: type: "object"
													spec: {
														properties: {
															accessModes: {
																items: type: "string"
																type: "array"
															}
															dataSource: {
																properties: {
																	apiGroup: type: "string"
																	kind: type: "string"
																	name: type: "string"
																}
																required: [
																	"kind",
																	"name",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															dataSourceRef: {
																properties: {
																	apiGroup: type: "string"
																	kind: type: "string"
																	name: type: "string"
																	namespace: type: "string"
																}
																required: [
																	"kind",
																	"name",
																]
																type: "object"
															}
															resources: {
																properties: {
																	limits: {
																		additionalProperties: {
																			anyOf: [{
																				type: "integer"
																			}, {
																				type: "string"
																			}]
																			pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																			"x-kubernetes-int-or-string": true
																		}
																		type: "object"
																	}
																	requests: {
																		additionalProperties: {
																			anyOf: [{
																				type: "integer"
																			}, {
																				type: "string"
																			}]
																			pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																			"x-kubernetes-int-or-string": true
																		}
																		type: "object"
																	}
																}
																type: "object"
															}
															selector: {
																properties: {
																	matchExpressions: {
																		items: {
																			properties: {
																				key: type: "string"
																				operator: type: "string"
																				values: {
																					items: type: "string"
																					type: "array"
																				}
																			}
																			required: [
																				"key",
																				"operator",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	matchLabels: {
																		additionalProperties: type: "string"
																		type: "object"
																	}
																}
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															storageClassName: type: "string"
															volumeAttributesClassName: type: "string"
															volumeMode: type: "string"
															volumeName: type: "string"
														}
														type: "object"
													}
												}
												required: [
													"spec",
												]
												type: "object"
											}
											type: "object"
										}
										fc: {
											properties: {
												fsType: type: "string"
												lun: {
													format: "int32"
													type:   "integer"
												}
												readOnly: type: "boolean"
												targetWWNs: {
													items: type: "string"
													type: "array"
												}
												wwids: {
													items: type: "string"
													type: "array"
												}
											}
											type: "object"
										}
										flexVolume: {
											properties: {
												driver: type: "string"
												fsType: type: "string"
												options: {
													additionalProperties: type: "string"
													type: "object"
												}
												readOnly: type: "boolean"
												secretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
											}
											required: [
												"driver",
											]
											type: "object"
										}
										flocker: {
											properties: {
												datasetName: type: "string"
												datasetUUID: type: "string"
											}
											type: "object"
										}
										gcePersistentDisk: {
											properties: {
												fsType: type: "string"
												partition: {
													format: "int32"
													type:   "integer"
												}
												pdName: type: "string"
												readOnly: type: "boolean"
											}
											required: [
												"pdName",
											]
											type: "object"
										}
										gitRepo: {
											properties: {
												directory: type: "string"
												repository: type: "string"
												revision: type: "string"
											}
											required: [
												"repository",
											]
											type: "object"
										}
										glusterfs: {
											properties: {
												endpoints: type: "string"
												path: type: "string"
												readOnly: type: "boolean"
											}
											required: [
												"endpoints",
												"path",
											]
											type: "object"
										}
										hostPath: {
											properties: {
												path: type: "string"
												type: type: "string"
											}
											required: [
												"path",
											]
											type: "object"
										}
										iscsi: {
											properties: {
												chapAuthDiscovery: type: "boolean"
												chapAuthSession: type: "boolean"
												fsType: type: "string"
												initiatorName: type: "string"
												iqn: type: "string"
												iscsiInterface: type: "string"
												lun: {
													format: "int32"
													type:   "integer"
												}
												portals: {
													items: type: "string"
													type: "array"
												}
												readOnly: type: "boolean"
												secretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												targetPortal: type: "string"
											}
											required: [
												"iqn",
												"lun",
												"targetPortal",
											]
											type: "object"
										}
										name: type: "string"
										nfs: {
											properties: {
												path: type: "string"
												readOnly: type: "boolean"
												server: type: "string"
											}
											required: [
												"path",
												"server",
											]
											type: "object"
										}
										persistentVolumeClaim: {
											properties: {
												claimName: type: "string"
												readOnly: type: "boolean"
											}
											required: [
												"claimName",
											]
											type: "object"
										}
										photonPersistentDisk: {
											properties: {
												fsType: type: "string"
												pdID: type: "string"
											}
											required: [
												"pdID",
											]
											type: "object"
										}
										portworxVolume: {
											properties: {
												fsType: type: "string"
												readOnly: type: "boolean"
												volumeID: type: "string"
											}
											required: [
												"volumeID",
											]
											type: "object"
										}
										projected: {
											properties: {
												defaultMode: {
													format: "int32"
													type:   "integer"
												}
												sources: {
													items: {
														properties: {
															clusterTrustBundle: {
																properties: {
																	labelSelector: {
																		properties: {
																			matchExpressions: {
																				items: {
																					properties: {
																						key: type: "string"
																						operator: type: "string"
																						values: {
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			matchLabels: {
																				additionalProperties: type: "string"
																				type: "object"
																			}
																		}
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	name: type: "string"
																	optional: type: "boolean"
																	path: type: "string"
																	signerName: type: "string"
																}
																required: [
																	"path",
																]
																type: "object"
															}
															configMap: {
																properties: {
																	items: {
																		items: {
																			properties: {
																				key: type: "string"
																				mode: {
																					format: "int32"
																					type:   "integer"
																				}
																				path: type: "string"
																			}
																			required: [
																				"key",
																				"path",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	name: type: "string"
																	optional: type: "boolean"
																}
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															downwardAPI: {
																properties: items: {
																	items: {
																		properties: {
																			fieldRef: {
																				properties: {
																					apiVersion: type: "string"
																					fieldPath: type: "string"
																				}
																				required: [
																					"fieldPath",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			mode: {
																				format: "int32"
																				type:   "integer"
																			}
																			path: type: "string"
																			resourceFieldRef: {
																				properties: {
																					containerName: type: "string"
																					divisor: {
																						anyOf: [{
																							type: "integer"
																						}, {
																							type: "string"
																						}]
																						pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																						"x-kubernetes-int-or-string": true
																					}
																					resource: type: "string"
																				}
																				required: [
																					"resource",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		required: [
																			"path",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																type: "object"
															}
															secret: {
																properties: {
																	items: {
																		items: {
																			properties: {
																				key: type: "string"
																				mode: {
																					format: "int32"
																					type:   "integer"
																				}
																				path: type: "string"
																			}
																			required: [
																				"key",
																				"path",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	name: type: "string"
																	optional: type: "boolean"
																}
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															serviceAccountToken: {
																properties: {
																	audience: type: "string"
																	expirationSeconds: {
																		format: "int64"
																		type:   "integer"
																	}
																	path: type: "string"
																}
																required: [
																	"path",
																]
																type: "object"
															}
														}
														type: "object"
													}
													type: "array"
												}
											}
											type: "object"
										}
										quobyte: {
											properties: {
												group: type: "string"
												readOnly: type: "boolean"
												registry: type: "string"
												tenant: type: "string"
												user: type: "string"
												volume: type: "string"
											}
											required: [
												"registry",
												"volume",
											]
											type: "object"
										}
										rbd: {
											properties: {
												fsType: type: "string"
												image: type: "string"
												keyring: type: "string"
												monitors: {
													items: type: "string"
													type: "array"
												}
												pool: type: "string"
												readOnly: type: "boolean"
												secretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												user: type: "string"
											}
											required: [
												"image",
												"monitors",
											]
											type: "object"
										}
										scaleIO: {
											properties: {
												fsType: type: "string"
												gateway: type: "string"
												protectionDomain: type: "string"
												readOnly: type: "boolean"
												secretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												sslEnabled: type: "boolean"
												storageMode: type: "string"
												storagePool: type: "string"
												system: type: "string"
												volumeName: type: "string"
											}
											required: [
												"gateway",
												"secretRef",
												"system",
											]
											type: "object"
										}
										secret: {
											properties: {
												defaultMode: {
													format: "int32"
													type:   "integer"
												}
												items: {
													items: {
														properties: {
															key: type: "string"
															mode: {
																format: "int32"
																type:   "integer"
															}
															path: type: "string"
														}
														required: [
															"key",
															"path",
														]
														type: "object"
													}
													type: "array"
												}
												optional: type: "boolean"
												secretName: type: "string"
											}
											type: "object"
										}
										storageos: {
											properties: {
												fsType: type: "string"
												readOnly: type: "boolean"
												secretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												volumeName: type: "string"
												volumeNamespace: type: "string"
											}
											type: "object"
										}
										vsphereVolume: {
											properties: {
												fsType: type: "string"
												storagePolicyID: type: "string"
												storagePolicyName: type: "string"
												volumePath: type: "string"
											}
											required: [
												"volumePath",
											]
											type: "object"
										}
									}
									required: [
										"name",
									]
									type: "object"
								}
								type: "array"
							}
							walCompression: type: "boolean"
							web: {
								properties: {
									httpConfig: {
										properties: {
											headers: {
												properties: {
													contentSecurityPolicy: type: "string"
													strictTransportSecurity: type: "string"
													xContentTypeOptions: {
														enum: [
															"",
															"NoSniff",
														]
														type: "string"
													}
													xFrameOptions: {
														enum: [
															"",
															"Deny",
															"SameOrigin",
														]
														type: "string"
													}
													xXSSProtection: type: "string"
												}
												type: "object"
											}
											http2: type: "boolean"
										}
										type: "object"
									}
									maxConnections: {
										format:  "int32"
										minimum: 0
										type:    "integer"
									}
									pageTitle: type: "string"
									tlsConfig: {
										properties: {
											cert: {
												properties: {
													configMap: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													secret: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											cipherSuites: {
												items: type: "string"
												type: "array"
											}
											client_ca: {
												properties: {
													configMap: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													secret: {
														properties: {
															key: type: "string"
															name: type: "string"
															optional: type: "boolean"
														}
														required: [
															"key",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											clientAuthType: type: "string"
											curvePreferences: {
												items: type: "string"
												type: "array"
											}
											keySecret: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											maxVersion: type: "string"
											minVersion: type: "string"
											preferServerCipherSuites: type: "boolean"
										}
										required: [
											"cert",
											"keySecret",
										]
										type: "object"
									}
								}
								type: "object"
							}
						}
						type: "object"
					}
					status: {
						properties: {
							availableReplicas: {
								format: "int32"
								type:   "integer"
							}
							conditions: {
								items: {
									properties: {
										lastTransitionTime: {
											format: "date-time"
											type:   "string"
										}
										message: type: "string"
										observedGeneration: {
											format: "int64"
											type:   "integer"
										}
										reason: type: "string"
										status: type: "string"
										type: type: "string"
									}
									required: [
										"lastTransitionTime",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
								"x-kubernetes-list-map-keys": [
									"type",
								]
								"x-kubernetes-list-type": "map"
							}
							paused: type: "boolean"
							replicas: {
								format: "int32"
								type:   "integer"
							}
							selector: type: "string"
							shardStatuses: {
								items: {
									properties: {
										availableReplicas: {
											format: "int32"
											type:   "integer"
										}
										replicas: {
											format: "int32"
											type:   "integer"
										}
										shardID: type: "string"
										unavailableReplicas: {
											format: "int32"
											type:   "integer"
										}
										updatedReplicas: {
											format: "int32"
											type:   "integer"
										}
									}
									required: [
										"availableReplicas",
										"replicas",
										"shardID",
										"unavailableReplicas",
										"updatedReplicas",
									]
									type: "object"
								}
								type: "array"
								"x-kubernetes-list-map-keys": [
									"shardID",
								]
								"x-kubernetes-list-type": "map"
							}
							shards: {
								format: "int32"
								type:   "integer"
							}
							unavailableReplicas: {
								format: "int32"
								type:   "integer"
							}
							updatedReplicas: {
								format: "int32"
								type:   "integer"
							}
						}
						required: [
							"availableReplicas",
							"paused",
							"replicas",
							"unavailableReplicas",
							"updatedReplicas",
						]
						type: "object"
					}
				}
				required: [
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
			subresources: {
				scale: {
					labelSelectorPath:  ".status.selector"
					specReplicasPath:   ".spec.shards"
					statusReplicasPath: ".status.shards"
				}
				status: {}
			}
		}]
	}
}, {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: {
			"controller-gen.kubebuilder.io/version": "v0.13.0"
			"operator.prometheus.io/version":        "0.72.0"
		}
		name: "prometheusrules.monitoring.coreos.com"
	}
	spec: {
		group: "monitoring.coreos.com"
		names: {
			categories: [
				"prometheus-operator",
			]
			kind:     "PrometheusRule"
			listKind: "PrometheusRuleList"
			plural:   "prometheusrules"
			shortNames: [
				"promrule",
			]
			singular: "prometheusrule"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				properties: {
					apiVersion: type: "string"
					kind: type: "string"
					metadata: type: "object"
					spec: {
						properties: groups: {
							items: {
								properties: {
									interval: {
										pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
										type:    "string"
									}
									limit: type: "integer"
									name: {
										minLength: 1
										type:      "string"
									}
									partial_response_strategy: {
										pattern: "^(?i)(abort|warn)?$"
										type:    "string"
									}
									rules: {
										items: {
											properties: {
												alert: type: "string"
												annotations: {
													additionalProperties: type: "string"
													type: "object"
												}
												expr: {
													anyOf: [{
														type: "integer"
													}, {
														type: "string"
													}]
													"x-kubernetes-int-or-string": true
												}
												for: {
													pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
													type:    "string"
												}
												keep_firing_for: {
													minLength: 1
													pattern:   "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
													type:      "string"
												}
												labels: {
													additionalProperties: type: "string"
													type: "object"
												}
												record: type: "string"
											}
											required: [
												"expr",
											]
											type: "object"
										}
										type: "array"
									}
								}
								required: [
									"name",
								]
								type: "object"
							}
							type: "array"
							"x-kubernetes-list-map-keys": [
								"name",
							]
							"x-kubernetes-list-type": "map"
						}
						type: "object"
					}
				}
				required: [
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
		}]
	}
}, {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: {
			"controller-gen.kubebuilder.io/version": "v0.13.0"
			"operator.prometheus.io/version":        "0.72.0"
		}
		name: "scrapeconfigs.monitoring.coreos.com"
	}
	spec: {
		group: "monitoring.coreos.com"
		names: {
			categories: [
				"prometheus-operator",
			]
			kind:     "ScrapeConfig"
			listKind: "ScrapeConfigList"
			plural:   "scrapeconfigs"
			shortNames: [
				"scfg",
			]
			singular: "scrapeconfig"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				properties: {
					apiVersion: type: "string"
					kind: type: "string"
					metadata: type: "object"
					spec: {
						properties: {
							authorization: {
								properties: {
									credentials: {
										properties: {
											key: type: "string"
											name: type: "string"
											optional: type: "boolean"
										}
										required: [
											"key",
										]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
									type: type: "string"
								}
								type: "object"
							}
							azureSDConfigs: {
								items: {
									properties: {
										authenticationMethod: {
											enum: [
												"OAuth",
												"ManagedIdentity",
											]
											type: "string"
										}
										clientID: type: "string"
										clientSecret: {
											properties: {
												key: type: "string"
												name: type: "string"
												optional: type: "boolean"
											}
											required: [
												"key",
											]
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										environment: type: "string"
										port: type: "integer"
										refreshInterval: {
											pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
											type:    "string"
										}
										resourceGroup: type: "string"
										subscriptionID: {
											minLength: 1
											type:      "string"
										}
										tenantID: type: "string"
									}
									required: [
										"subscriptionID",
									]
									type: "object"
								}
								type: "array"
							}
							basicAuth: {
								properties: {
									password: {
										properties: {
											key: type: "string"
											name: type: "string"
											optional: type: "boolean"
										}
										required: [
											"key",
										]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
									username: {
										properties: {
											key: type: "string"
											name: type: "string"
											optional: type: "boolean"
										}
										required: [
											"key",
										]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
								}
								type: "object"
							}
							consulSDConfigs: {
								items: {
									properties: {
										allowStale: type: "boolean"
										authorization: {
											properties: {
												credentials: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												type: type: "string"
											}
											type: "object"
										}
										basicAuth: {
											properties: {
												password: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												username: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
											}
											type: "object"
										}
										datacenter: type: "string"
										enableHTTP2: type: "boolean"
										followRedirects: type: "boolean"
										namespace: type: "string"
										noProxy: type: "string"
										nodeMeta: {
											additionalProperties: type: "string"
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										oauth2: {
											properties: {
												clientId: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												clientSecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												endpointParams: {
													additionalProperties: type: "string"
													type: "object"
												}
												scopes: {
													items: type: "string"
													type: "array"
												}
												tokenUrl: {
													minLength: 1
													type:      "string"
												}
											}
											required: [
												"clientId",
												"clientSecret",
												"tokenUrl",
											]
											type: "object"
										}
										partition: type: "string"
										proxyConnectHeader: {
											additionalProperties: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										proxyFromEnvironment: type: "boolean"
										proxyUrl: {
											pattern: "^http(s)?://.+$"
											type:    "string"
										}
										refreshInterval: {
											pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
											type:    "string"
										}
										scheme: {
											enum: [
												"HTTP",
												"HTTPS",
											]
											type: "string"
										}
										server: {
											minLength: 1
											type:      "string"
										}
										services: {
											items: type: "string"
											type:                     "array"
											"x-kubernetes-list-type": "atomic"
										}
										tagSeparator: type: "string"
										tags: {
											items: type: "string"
											type:                     "array"
											"x-kubernetes-list-type": "atomic"
										}
										tlsConfig: {
											properties: {
												ca: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												cert: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												insecureSkipVerify: type: "boolean"
												keySecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												serverName: type: "string"
											}
											type: "object"
										}
										tokenRef: {
											properties: {
												key: type: "string"
												name: type: "string"
												optional: type: "boolean"
											}
											required: [
												"key",
											]
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
									}
									required: [
										"server",
									]
									type: "object"
								}
								type: "array"
							}
							digitalOceanSDConfigs: {
								items: {
									properties: {
										authorization: {
											properties: {
												credentials: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												type: type: "string"
											}
											type: "object"
										}
										enableHTTP2: type: "boolean"
										followRedirects: type: "boolean"
										noProxy: type: "string"
										oauth2: {
											properties: {
												clientId: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												clientSecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												endpointParams: {
													additionalProperties: type: "string"
													type: "object"
												}
												scopes: {
													items: type: "string"
													type: "array"
												}
												tokenUrl: {
													minLength: 1
													type:      "string"
												}
											}
											required: [
												"clientId",
												"clientSecret",
												"tokenUrl",
											]
											type: "object"
										}
										port: type: "integer"
										proxyConnectHeader: {
											additionalProperties: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										proxyFromEnvironment: type: "boolean"
										proxyUrl: {
											pattern: "^http(s)?://.+$"
											type:    "string"
										}
										refreshInterval: {
											pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
											type:    "string"
										}
										tlsConfig: {
											properties: {
												ca: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												cert: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												insecureSkipVerify: type: "boolean"
												keySecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												serverName: type: "string"
											}
											type: "object"
										}
									}
									type: "object"
								}
								type: "array"
							}
							dnsSDConfigs: {
								items: {
									properties: {
										names: {
											items: type: "string"
											minItems: 1
											type:     "array"
										}
										port: type: "integer"
										refreshInterval: {
											pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
											type:    "string"
										}
										type: {
											enum: [
												"SRV",
												"A",
												"AAAA",
												"MX",
												"NS",
											]
											type: "string"
										}
									}
									required: [
										"names",
									]
									type: "object"
								}
								type: "array"
							}
							ec2SDConfigs: {
								items: {
									properties: {
										accessKey: {
											properties: {
												key: type: "string"
												name: type: "string"
												optional: type: "boolean"
											}
											required: [
												"key",
											]
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										filters: {
											items: {
												properties: {
													name: type: "string"
													values: {
														items: type: "string"
														type: "array"
													}
												}
												required: [
													"name",
													"values",
												]
												type: "object"
											}
											type: "array"
										}
										port: type: "integer"
										refreshInterval: {
											pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
											type:    "string"
										}
										region: type: "string"
										roleARN: type: "string"
										secretKey: {
											properties: {
												key: type: "string"
												name: type: "string"
												optional: type: "boolean"
											}
											required: [
												"key",
											]
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
									}
									type: "object"
								}
								type: "array"
							}
							enableCompression: type: "boolean"
							fileSDConfigs: {
								items: {
									properties: {
										files: {
											items: {
												pattern: "^[^*]*(\\*[^/]*)?\\.(json|yml|yaml|JSON|YML|YAML)$"
												type:    "string"
											}
											minItems: 1
											type:     "array"
										}
										refreshInterval: {
											pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
											type:    "string"
										}
									}
									required: [
										"files",
									]
									type: "object"
								}
								type: "array"
							}
							gceSDConfigs: {
								items: {
									properties: {
										filter: type: "string"
										port: type: "integer"
										project: {
											minLength: 1
											type:      "string"
										}
										refreshInterval: {
											pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
											type:    "string"
										}
										tagSeparator: type: "string"
										zone: {
											minLength: 1
											type:      "string"
										}
									}
									required: [
										"project",
										"zone",
									]
									type: "object"
								}
								type: "array"
							}
							honorLabels: type: "boolean"
							honorTimestamps: type: "boolean"
							httpSDConfigs: {
								items: {
									properties: {
										authorization: {
											properties: {
												credentials: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												type: type: "string"
											}
											type: "object"
										}
										basicAuth: {
											properties: {
												password: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												username: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
											}
											type: "object"
										}
										noProxy: type: "string"
										proxyConnectHeader: {
											additionalProperties: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										proxyFromEnvironment: type: "boolean"
										proxyUrl: {
											pattern: "^http(s)?://.+$"
											type:    "string"
										}
										refreshInterval: {
											pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
											type:    "string"
										}
										tlsConfig: {
											properties: {
												ca: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												cert: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												insecureSkipVerify: type: "boolean"
												keySecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												serverName: type: "string"
											}
											type: "object"
										}
										url: {
											minLength: 1
											pattern:   "^http(s)?://.+$"
											type:      "string"
										}
									}
									required: [
										"url",
									]
									type: "object"
								}
								type: "array"
							}
							keepDroppedTargets: {
								format: "int64"
								type:   "integer"
							}
							kubernetesSDConfigs: {
								items: {
									properties: {
										apiServer: type: "string"
										attachMetadata: {
											properties: node: type: "boolean"
											type: "object"
										}
										authorization: {
											properties: {
												credentials: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												type: type: "string"
											}
											type: "object"
										}
										basicAuth: {
											properties: {
												password: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												username: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
											}
											type: "object"
										}
										enableHTTP2: type: "boolean"
										followRedirects: type: "boolean"
										namespaces: {
											properties: {
												names: {
													items: type: "string"
													type: "array"
												}
												ownNamespace: type: "boolean"
											}
											type: "object"
										}
										noProxy: type: "string"
										oauth2: {
											properties: {
												clientId: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												clientSecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												endpointParams: {
													additionalProperties: type: "string"
													type: "object"
												}
												scopes: {
													items: type: "string"
													type: "array"
												}
												tokenUrl: {
													minLength: 1
													type:      "string"
												}
											}
											required: [
												"clientId",
												"clientSecret",
												"tokenUrl",
											]
											type: "object"
										}
										proxyConnectHeader: {
											additionalProperties: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										proxyFromEnvironment: type: "boolean"
										proxyUrl: {
											pattern: "^http(s)?://.+$"
											type:    "string"
										}
										role: {
											enum: [
												"Node",
												"node",
												"Service",
												"service",
												"Pod",
												"pod",
												"Endpoints",
												"endpoints",
												"EndpointSlice",
												"endpointslice",
												"Ingress",
												"ingress",
											]
											type: "string"
										}
										selectors: {
											items: {
												properties: {
													field: type: "string"
													label: type: "string"
													role: {
														enum: [
															"Node",
															"node",
															"Service",
															"service",
															"Pod",
															"pod",
															"Endpoints",
															"endpoints",
															"EndpointSlice",
															"endpointslice",
															"Ingress",
															"ingress",
														]
														type: "string"
													}
												}
												required: [
													"role",
												]
												type: "object"
											}
											type: "array"
											"x-kubernetes-list-map-keys": [
												"role",
											]
											"x-kubernetes-list-type": "map"
										}
										tlsConfig: {
											properties: {
												ca: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												cert: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												insecureSkipVerify: type: "boolean"
												keySecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												serverName: type: "string"
											}
											type: "object"
										}
									}
									required: [
										"role",
									]
									type: "object"
								}
								type: "array"
							}
							labelLimit: {
								format: "int64"
								type:   "integer"
							}
							labelNameLengthLimit: {
								format: "int64"
								type:   "integer"
							}
							labelValueLengthLimit: {
								format: "int64"
								type:   "integer"
							}
							metricRelabelings: {
								items: {
									properties: {
										action: {
											default: "replace"
											enum: [
												"replace",
												"Replace",
												"keep",
												"Keep",
												"drop",
												"Drop",
												"hashmod",
												"HashMod",
												"labelmap",
												"LabelMap",
												"labeldrop",
												"LabelDrop",
												"labelkeep",
												"LabelKeep",
												"lowercase",
												"Lowercase",
												"uppercase",
												"Uppercase",
												"keepequal",
												"KeepEqual",
												"dropequal",
												"DropEqual",
											]
											type: "string"
										}
										modulus: {
											format: "int64"
											type:   "integer"
										}
										regex: type: "string"
										replacement: type: "string"
										separator: type: "string"
										sourceLabels: {
											items: {
												pattern: "^[a-zA-Z_][a-zA-Z0-9_]*$"
												type:    "string"
											}
											type: "array"
										}
										targetLabel: type: "string"
									}
									type: "object"
								}
								type: "array"
							}
							metricsPath: type: "string"
							noProxy: type: "string"
							openstackSDConfigs: {
								items: {
									properties: {
										allTenants: type: "boolean"
										applicationCredentialId: type: "string"
										applicationCredentialName: type: "string"
										applicationCredentialSecret: {
											properties: {
												key: type: "string"
												name: type: "string"
												optional: type: "boolean"
											}
											required: [
												"key",
											]
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										availability: {
											enum: [
												"Public",
												"public",
												"Admin",
												"admin",
												"Internal",
												"internal",
											]
											type: "string"
										}
										domainID: type: "string"
										domainName: type: "string"
										identityEndpoint: type: "string"
										password: {
											properties: {
												key: type: "string"
												name: type: "string"
												optional: type: "boolean"
											}
											required: [
												"key",
											]
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										port: type: "integer"
										projectID: type: "string"
										projectName: type: "string"
										refreshInterval: {
											pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
											type:    "string"
										}
										region: {
											minLength: 1
											type:      "string"
										}
										role: {
											enum: [
												"Instance",
												"instance",
												"Hypervisor",
												"hypervisor",
											]
											type: "string"
										}
										tlsConfig: {
											properties: {
												ca: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												cert: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												insecureSkipVerify: type: "boolean"
												keySecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												serverName: type: "string"
											}
											type: "object"
										}
										userid: type: "string"
										username: type: "string"
									}
									required: [
										"region",
										"role",
									]
									type: "object"
								}
								type: "array"
							}
							params: {
								additionalProperties: {
									items: type: "string"
									type: "array"
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							proxyConnectHeader: {
								additionalProperties: {
									properties: {
										key: type: "string"
										name: type: "string"
										optional: type: "boolean"
									}
									required: [
										"key",
									]
									type:                    "object"
									"x-kubernetes-map-type": "atomic"
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							proxyFromEnvironment: type: "boolean"
							proxyUrl: {
								pattern: "^http(s)?://.+$"
								type:    "string"
							}
							relabelings: {
								items: {
									properties: {
										action: {
											default: "replace"
											enum: [
												"replace",
												"Replace",
												"keep",
												"Keep",
												"drop",
												"Drop",
												"hashmod",
												"HashMod",
												"labelmap",
												"LabelMap",
												"labeldrop",
												"LabelDrop",
												"labelkeep",
												"LabelKeep",
												"lowercase",
												"Lowercase",
												"uppercase",
												"Uppercase",
												"keepequal",
												"KeepEqual",
												"dropequal",
												"DropEqual",
											]
											type: "string"
										}
										modulus: {
											format: "int64"
											type:   "integer"
										}
										regex: type: "string"
										replacement: type: "string"
										separator: type: "string"
										sourceLabels: {
											items: {
												pattern: "^[a-zA-Z_][a-zA-Z0-9_]*$"
												type:    "string"
											}
											type: "array"
										}
										targetLabel: type: "string"
									}
									type: "object"
								}
								type: "array"
							}
							sampleLimit: {
								format: "int64"
								type:   "integer"
							}
							scheme: {
								enum: [
									"HTTP",
									"HTTPS",
								]
								type: "string"
							}
							scrapeClass: {
								minLength: 1
								type:      "string"
							}
							scrapeInterval: {
								pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
								type:    "string"
							}
							scrapeProtocols: {
								items: {
									enum: [
										"PrometheusProto",
										"OpenMetricsText0.0.1",
										"OpenMetricsText1.0.0",
										"PrometheusText0.0.4",
									]
									type: "string"
								}
								type:                     "array"
								"x-kubernetes-list-type": "set"
							}
							scrapeTimeout: {
								pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
								type:    "string"
							}
							staticConfigs: {
								items: {
									properties: {
										labels: {
											additionalProperties: type: "string"
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										targets: {
											items: type: "string"
											type: "array"
										}
									}
									type: "object"
								}
								type: "array"
							}
							targetLimit: {
								format: "int64"
								type:   "integer"
							}
							tlsConfig: {
								properties: {
									ca: {
										properties: {
											configMap: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											secret: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
										}
										type: "object"
									}
									cert: {
										properties: {
											configMap: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											secret: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
										}
										type: "object"
									}
									insecureSkipVerify: type: "boolean"
									keySecret: {
										properties: {
											key: type: "string"
											name: type: "string"
											optional: type: "boolean"
										}
										required: [
											"key",
										]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
									serverName: type: "string"
								}
								type: "object"
							}
							trackTimestampsStaleness: type: "boolean"
						}
						type: "object"
					}
				}
				required: [
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
		}]
	}
}, {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: {
			"controller-gen.kubebuilder.io/version": "v0.13.0"
			"operator.prometheus.io/version":        "0.72.0"
		}
		name: "servicemonitors.monitoring.coreos.com"
	}
	spec: {
		group: "monitoring.coreos.com"
		names: {
			categories: [
				"prometheus-operator",
			]
			kind:     "ServiceMonitor"
			listKind: "ServiceMonitorList"
			plural:   "servicemonitors"
			shortNames: [
				"smon",
			]
			singular: "servicemonitor"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				properties: {
					apiVersion: type: "string"
					kind: type: "string"
					metadata: type: "object"
					spec: {
						properties: {
							attachMetadata: {
								properties: node: type: "boolean"
								type: "object"
							}
							endpoints: {
								items: {
									properties: {
										authorization: {
											properties: {
												credentials: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												type: type: "string"
											}
											type: "object"
										}
										basicAuth: {
											properties: {
												password: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												username: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
											}
											type: "object"
										}
										bearerTokenFile: type: "string"
										bearerTokenSecret: {
											properties: {
												key: type: "string"
												name: type: "string"
												optional: type: "boolean"
											}
											required: [
												"key",
											]
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										enableHttp2: type: "boolean"
										filterRunning: type: "boolean"
										followRedirects: type: "boolean"
										honorLabels: type: "boolean"
										honorTimestamps: type: "boolean"
										interval: {
											pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
											type:    "string"
										}
										metricRelabelings: {
											items: {
												properties: {
													action: {
														default: "replace"
														enum: [
															"replace",
															"Replace",
															"keep",
															"Keep",
															"drop",
															"Drop",
															"hashmod",
															"HashMod",
															"labelmap",
															"LabelMap",
															"labeldrop",
															"LabelDrop",
															"labelkeep",
															"LabelKeep",
															"lowercase",
															"Lowercase",
															"uppercase",
															"Uppercase",
															"keepequal",
															"KeepEqual",
															"dropequal",
															"DropEqual",
														]
														type: "string"
													}
													modulus: {
														format: "int64"
														type:   "integer"
													}
													regex: type: "string"
													replacement: type: "string"
													separator: type: "string"
													sourceLabels: {
														items: {
															pattern: "^[a-zA-Z_][a-zA-Z0-9_]*$"
															type:    "string"
														}
														type: "array"
													}
													targetLabel: type: "string"
												}
												type: "object"
											}
											type: "array"
										}
										oauth2: {
											properties: {
												clientId: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												clientSecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												endpointParams: {
													additionalProperties: type: "string"
													type: "object"
												}
												scopes: {
													items: type: "string"
													type: "array"
												}
												tokenUrl: {
													minLength: 1
													type:      "string"
												}
											}
											required: [
												"clientId",
												"clientSecret",
												"tokenUrl",
											]
											type: "object"
										}
										params: {
											additionalProperties: {
												items: type: "string"
												type: "array"
											}
											type: "object"
										}
										path: type: "string"
										port: type: "string"
										proxyUrl: type: "string"
										relabelings: {
											items: {
												properties: {
													action: {
														default: "replace"
														enum: [
															"replace",
															"Replace",
															"keep",
															"Keep",
															"drop",
															"Drop",
															"hashmod",
															"HashMod",
															"labelmap",
															"LabelMap",
															"labeldrop",
															"LabelDrop",
															"labelkeep",
															"LabelKeep",
															"lowercase",
															"Lowercase",
															"uppercase",
															"Uppercase",
															"keepequal",
															"KeepEqual",
															"dropequal",
															"DropEqual",
														]
														type: "string"
													}
													modulus: {
														format: "int64"
														type:   "integer"
													}
													regex: type: "string"
													replacement: type: "string"
													separator: type: "string"
													sourceLabels: {
														items: {
															pattern: "^[a-zA-Z_][a-zA-Z0-9_]*$"
															type:    "string"
														}
														type: "array"
													}
													targetLabel: type: "string"
												}
												type: "object"
											}
											type: "array"
										}
										scheme: {
											enum: [
												"http",
												"https",
											]
											type: "string"
										}
										scrapeTimeout: {
											pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
											type:    "string"
										}
										targetPort: {
											anyOf: [{
												type: "integer"
											}, {
												type: "string"
											}]
											"x-kubernetes-int-or-string": true
										}
										tlsConfig: {
											properties: {
												ca: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												caFile: type: "string"
												cert: {
													properties: {
														configMap: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														secret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: [
																"key",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
													}
													type: "object"
												}
												certFile: type: "string"
												insecureSkipVerify: type: "boolean"
												keyFile: type: "string"
												keySecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: [
														"key",
													]
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												serverName: type: "string"
											}
											type: "object"
										}
										trackTimestampsStaleness: type: "boolean"
									}
									type: "object"
								}
								type: "array"
							}
							jobLabel: type: "string"
							keepDroppedTargets: {
								format: "int64"
								type:   "integer"
							}
							labelLimit: {
								format: "int64"
								type:   "integer"
							}
							labelNameLengthLimit: {
								format: "int64"
								type:   "integer"
							}
							labelValueLengthLimit: {
								format: "int64"
								type:   "integer"
							}
							namespaceSelector: {
								properties: {
									any: type: "boolean"
									matchNames: {
										items: type: "string"
										type: "array"
									}
								}
								type: "object"
							}
							podTargetLabels: {
								items: type: "string"
								type: "array"
							}
							sampleLimit: {
								format: "int64"
								type:   "integer"
							}
							scrapeClass: {
								minLength: 1
								type:      "string"
							}
							scrapeProtocols: {
								items: {
									enum: [
										"PrometheusProto",
										"OpenMetricsText0.0.1",
										"OpenMetricsText1.0.0",
										"PrometheusText0.0.4",
									]
									type: "string"
								}
								type:                     "array"
								"x-kubernetes-list-type": "set"
							}
							selector: {
								properties: {
									matchExpressions: {
										items: {
											properties: {
												key: type: "string"
												operator: type: "string"
												values: {
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							targetLabels: {
								items: type: "string"
								type: "array"
							}
							targetLimit: {
								format: "int64"
								type:   "integer"
							}
						}
						required: [
							"selector",
						]
						type: "object"
					}
				}
				required: [
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
		}]
	}
}, {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: {
			"controller-gen.kubebuilder.io/version": "v0.13.0"
			"operator.prometheus.io/version":        "0.72.0"
		}
		name: "thanosrulers.monitoring.coreos.com"
	}
	spec: {
		group: "monitoring.coreos.com"
		names: {
			categories: [
				"prometheus-operator",
			]
			kind:     "ThanosRuler"
			listKind: "ThanosRulerList"
			plural:   "thanosrulers"
			shortNames: [
				"ruler",
			]
			singular: "thanosruler"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".spec.version"
				name:     "Version"
				type:     "string"
			}, {
				jsonPath: ".spec.replicas"
				name:     "Replicas"
				type:     "integer"
			}, {
				jsonPath: ".status.availableReplicas"
				name:     "Ready"
				type:     "integer"
			}, {
				jsonPath: ".status.conditions[?(@.type == 'Reconciled')].status"
				name:     "Reconciled"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type == 'Available')].status"
				name:     "Available"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}, {
				jsonPath: ".status.paused"
				name:     "Paused"
				priority: 1
				type:     "boolean"
			}]
			name: "v1"
			schema: openAPIV3Schema: {
				properties: {
					apiVersion: type: "string"
					kind: type: "string"
					metadata: type: "object"
					spec: {
						properties: {
							additionalArgs: {
								items: {
									properties: {
										name: {
											minLength: 1
											type:      "string"
										}
										value: type: "string"
									}
									required: [
										"name",
									]
									type: "object"
								}
								type: "array"
							}
							affinity: {
								properties: {
									nodeAffinity: {
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												items: {
													properties: {
														preference: {
															properties: {
																matchExpressions: {
																	items: {
																		properties: {
																			key: type: "string"
																			operator: type: "string"
																			values: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchFields: {
																	items: {
																		properties: {
																			key: type: "string"
																			operator: type: "string"
																			values: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														weight: {
															format: "int32"
															type:   "integer"
														}
													}
													required: [
														"preference",
														"weight",
													]
													type: "object"
												}
												type: "array"
											}
											requiredDuringSchedulingIgnoredDuringExecution: {
												properties: nodeSelectorTerms: {
													items: {
														properties: {
															matchExpressions: {
																items: {
																	properties: {
																		key: type: "string"
																		operator: type: "string"
																		values: {
																			items: type: "string"
																			type: "array"
																		}
																	}
																	required: [
																		"key",
																		"operator",
																	]
																	type: "object"
																}
																type: "array"
															}
															matchFields: {
																items: {
																	properties: {
																		key: type: "string"
																		operator: type: "string"
																		values: {
																			items: type: "string"
																			type: "array"
																		}
																	}
																	required: [
																		"key",
																		"operator",
																	]
																	type: "object"
																}
																type: "array"
															}
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													type: "array"
												}
												required: [
													"nodeSelectorTerms",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
										}
										type: "object"
									}
									podAffinity: {
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												items: {
													properties: {
														podAffinityTerm: {
															properties: {
																labelSelector: {
																	properties: {
																		matchExpressions: {
																			items: {
																				properties: {
																					key: type: "string"
																					operator: type: "string"
																					values: {
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchLabels: {
																			additionalProperties: type: "string"
																			type: "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																matchLabelKeys: {
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																mismatchLabelKeys: {
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																namespaceSelector: {
																	properties: {
																		matchExpressions: {
																			items: {
																				properties: {
																					key: type: "string"
																					operator: type: "string"
																					values: {
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchLabels: {
																			additionalProperties: type: "string"
																			type: "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																namespaces: {
																	items: type: "string"
																	type: "array"
																}
																topologyKey: type: "string"
															}
															required: [
																"topologyKey",
															]
															type: "object"
														}
														weight: {
															format: "int32"
															type:   "integer"
														}
													}
													required: [
														"podAffinityTerm",
														"weight",
													]
													type: "object"
												}
												type: "array"
											}
											requiredDuringSchedulingIgnoredDuringExecution: {
												items: {
													properties: {
														labelSelector: {
															properties: {
																matchExpressions: {
																	items: {
																		properties: {
																			key: type: "string"
																			operator: type: "string"
																			values: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														matchLabelKeys: {
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														mismatchLabelKeys: {
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														namespaceSelector: {
															properties: {
																matchExpressions: {
																	items: {
																		properties: {
																			key: type: "string"
																			operator: type: "string"
																			values: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														namespaces: {
															items: type: "string"
															type: "array"
														}
														topologyKey: type: "string"
													}
													required: [
														"topologyKey",
													]
													type: "object"
												}
												type: "array"
											}
										}
										type: "object"
									}
									podAntiAffinity: {
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												items: {
													properties: {
														podAffinityTerm: {
															properties: {
																labelSelector: {
																	properties: {
																		matchExpressions: {
																			items: {
																				properties: {
																					key: type: "string"
																					operator: type: "string"
																					values: {
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchLabels: {
																			additionalProperties: type: "string"
																			type: "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																matchLabelKeys: {
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																mismatchLabelKeys: {
																	items: type: "string"
																	type:                     "array"
																	"x-kubernetes-list-type": "atomic"
																}
																namespaceSelector: {
																	properties: {
																		matchExpressions: {
																			items: {
																				properties: {
																					key: type: "string"
																					operator: type: "string"
																					values: {
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchLabels: {
																			additionalProperties: type: "string"
																			type: "object"
																		}
																	}
																	type:                    "object"
																	"x-kubernetes-map-type": "atomic"
																}
																namespaces: {
																	items: type: "string"
																	type: "array"
																}
																topologyKey: type: "string"
															}
															required: [
																"topologyKey",
															]
															type: "object"
														}
														weight: {
															format: "int32"
															type:   "integer"
														}
													}
													required: [
														"podAffinityTerm",
														"weight",
													]
													type: "object"
												}
												type: "array"
											}
											requiredDuringSchedulingIgnoredDuringExecution: {
												items: {
													properties: {
														labelSelector: {
															properties: {
																matchExpressions: {
																	items: {
																		properties: {
																			key: type: "string"
																			operator: type: "string"
																			values: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														matchLabelKeys: {
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														mismatchLabelKeys: {
															items: type: "string"
															type:                     "array"
															"x-kubernetes-list-type": "atomic"
														}
														namespaceSelector: {
															properties: {
																matchExpressions: {
																	items: {
																		properties: {
																			key: type: "string"
																			operator: type: "string"
																			values: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														namespaces: {
															items: type: "string"
															type: "array"
														}
														topologyKey: type: "string"
													}
													required: [
														"topologyKey",
													]
													type: "object"
												}
												type: "array"
											}
										}
										type: "object"
									}
								}
								type: "object"
							}
							alertDropLabels: {
								items: type: "string"
								type: "array"
							}
							alertQueryUrl: type: "string"
							alertRelabelConfigFile: type: "string"
							alertRelabelConfigs: {
								properties: {
									key: type: "string"
									name: type: "string"
									optional: type: "boolean"
								}
								required: [
									"key",
								]
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							alertmanagersConfig: {
								properties: {
									key: type: "string"
									name: type: "string"
									optional: type: "boolean"
								}
								required: [
									"key",
								]
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							alertmanagersUrl: {
								items: type: "string"
								type: "array"
							}
							containers: {
								items: {
									properties: {
										args: {
											items: type: "string"
											type: "array"
										}
										command: {
											items: type: "string"
											type: "array"
										}
										env: {
											items: {
												properties: {
													name: type: "string"
													value: type: "string"
													valueFrom: {
														properties: {
															configMapKeyRef: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															fieldRef: {
																properties: {
																	apiVersion: type: "string"
																	fieldPath: type: "string"
																}
																required: [
																	"fieldPath",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															resourceFieldRef: {
																properties: {
																	containerName: type: "string"
																	divisor: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	resource: type: "string"
																}
																required: [
																	"resource",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															secretKeyRef: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
														}
														type: "object"
													}
												}
												required: [
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										envFrom: {
											items: {
												properties: {
													configMapRef: {
														properties: {
															name: type: "string"
															optional: type: "boolean"
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													prefix: type: "string"
													secretRef: {
														properties: {
															name: type: "string"
															optional: type: "boolean"
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											type: "array"
										}
										image: type: "string"
										imagePullPolicy: type: "string"
										lifecycle: {
											properties: {
												postStart: {
													properties: {
														exec: {
															properties: command: {
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														httpGet: {
															properties: {
																host: type: "string"
																httpHeaders: {
																	items: {
																		properties: {
																			name: type: "string"
																			value: type: "string"
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																path: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
																scheme: type: "string"
															}
															required: [
																"port",
															]
															type: "object"
														}
														sleep: {
															properties: seconds: {
																format: "int64"
																type:   "integer"
															}
															required: [
																"seconds",
															]
															type: "object"
														}
														tcpSocket: {
															properties: {
																host: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
															}
															required: [
																"port",
															]
															type: "object"
														}
													}
													type: "object"
												}
												preStop: {
													properties: {
														exec: {
															properties: command: {
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														httpGet: {
															properties: {
																host: type: "string"
																httpHeaders: {
																	items: {
																		properties: {
																			name: type: "string"
																			value: type: "string"
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																path: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
																scheme: type: "string"
															}
															required: [
																"port",
															]
															type: "object"
														}
														sleep: {
															properties: seconds: {
																format: "int64"
																type:   "integer"
															}
															required: [
																"seconds",
															]
															type: "object"
														}
														tcpSocket: {
															properties: {
																host: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
															}
															required: [
																"port",
															]
															type: "object"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										livenessProbe: {
											properties: {
												exec: {
													properties: command: {
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													format: "int32"
													type:   "integer"
												}
												grpc: {
													properties: {
														port: {
															format: "int32"
															type:   "integer"
														}
														service: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												httpGet: {
													properties: {
														host: type: "string"
														httpHeaders: {
															items: {
																properties: {
																	name: type: "string"
																	value: type: "string"
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
														scheme: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												initialDelaySeconds: {
													format: "int32"
													type:   "integer"
												}
												periodSeconds: {
													format: "int32"
													type:   "integer"
												}
												successThreshold: {
													format: "int32"
													type:   "integer"
												}
												tcpSocket: {
													properties: {
														host: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
													}
													required: [
														"port",
													]
													type: "object"
												}
												terminationGracePeriodSeconds: {
													format: "int64"
													type:   "integer"
												}
												timeoutSeconds: {
													format: "int32"
													type:   "integer"
												}
											}
											type: "object"
										}
										name: type: "string"
										ports: {
											items: {
												properties: {
													containerPort: {
														format: "int32"
														type:   "integer"
													}
													hostIP: type: "string"
													hostPort: {
														format: "int32"
														type:   "integer"
													}
													name: type: "string"
													protocol: {
														default: "TCP"
														type:    "string"
													}
												}
												required: [
													"containerPort",
												]
												type: "object"
											}
											type: "array"
											"x-kubernetes-list-map-keys": [
												"containerPort",
												"protocol",
											]
											"x-kubernetes-list-type": "map"
										}
										readinessProbe: {
											properties: {
												exec: {
													properties: command: {
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													format: "int32"
													type:   "integer"
												}
												grpc: {
													properties: {
														port: {
															format: "int32"
															type:   "integer"
														}
														service: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												httpGet: {
													properties: {
														host: type: "string"
														httpHeaders: {
															items: {
																properties: {
																	name: type: "string"
																	value: type: "string"
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
														scheme: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												initialDelaySeconds: {
													format: "int32"
													type:   "integer"
												}
												periodSeconds: {
													format: "int32"
													type:   "integer"
												}
												successThreshold: {
													format: "int32"
													type:   "integer"
												}
												tcpSocket: {
													properties: {
														host: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
													}
													required: [
														"port",
													]
													type: "object"
												}
												terminationGracePeriodSeconds: {
													format: "int64"
													type:   "integer"
												}
												timeoutSeconds: {
													format: "int32"
													type:   "integer"
												}
											}
											type: "object"
										}
										resizePolicy: {
											items: {
												properties: {
													resourceName: type: "string"
													restartPolicy: type: "string"
												}
												required: [
													"resourceName",
													"restartPolicy",
												]
												type: "object"
											}
											type:                     "array"
											"x-kubernetes-list-type": "atomic"
										}
										resources: {
											properties: {
												claims: {
													items: {
														properties: name: type: "string"
														required: [
															"name",
														]
														type: "object"
													}
													type: "array"
													"x-kubernetes-list-map-keys": [
														"name",
													]
													"x-kubernetes-list-type": "map"
												}
												limits: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													type: "object"
												}
												requests: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													type: "object"
												}
											}
											type: "object"
										}
										restartPolicy: type: "string"
										securityContext: {
											properties: {
												allowPrivilegeEscalation: type: "boolean"
												capabilities: {
													properties: {
														add: {
															items: type: "string"
															type: "array"
														}
														drop: {
															items: type: "string"
															type: "array"
														}
													}
													type: "object"
												}
												privileged: type: "boolean"
												procMount: type: "string"
												readOnlyRootFilesystem: type: "boolean"
												runAsGroup: {
													format: "int64"
													type:   "integer"
												}
												runAsNonRoot: type: "boolean"
												runAsUser: {
													format: "int64"
													type:   "integer"
												}
												seLinuxOptions: {
													properties: {
														level: type: "string"
														role: type: "string"
														type: type: "string"
														user: type: "string"
													}
													type: "object"
												}
												seccompProfile: {
													properties: {
														localhostProfile: type: "string"
														type: type: "string"
													}
													required: [
														"type",
													]
													type: "object"
												}
												windowsOptions: {
													properties: {
														gmsaCredentialSpec: type: "string"
														gmsaCredentialSpecName: type: "string"
														hostProcess: type: "boolean"
														runAsUserName: type: "string"
													}
													type: "object"
												}
											}
											type: "object"
										}
										startupProbe: {
											properties: {
												exec: {
													properties: command: {
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													format: "int32"
													type:   "integer"
												}
												grpc: {
													properties: {
														port: {
															format: "int32"
															type:   "integer"
														}
														service: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												httpGet: {
													properties: {
														host: type: "string"
														httpHeaders: {
															items: {
																properties: {
																	name: type: "string"
																	value: type: "string"
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
														scheme: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												initialDelaySeconds: {
													format: "int32"
													type:   "integer"
												}
												periodSeconds: {
													format: "int32"
													type:   "integer"
												}
												successThreshold: {
													format: "int32"
													type:   "integer"
												}
												tcpSocket: {
													properties: {
														host: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
													}
													required: [
														"port",
													]
													type: "object"
												}
												terminationGracePeriodSeconds: {
													format: "int64"
													type:   "integer"
												}
												timeoutSeconds: {
													format: "int32"
													type:   "integer"
												}
											}
											type: "object"
										}
										stdin: type: "boolean"
										stdinOnce: type: "boolean"
										terminationMessagePath: type: "string"
										terminationMessagePolicy: type: "string"
										tty: type: "boolean"
										volumeDevices: {
											items: {
												properties: {
													devicePath: type: "string"
													name: type: "string"
												}
												required: [
													"devicePath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										volumeMounts: {
											items: {
												properties: {
													mountPath: type: "string"
													mountPropagation: type: "string"
													name: type: "string"
													readOnly: type: "boolean"
													subPath: type: "string"
													subPathExpr: type: "string"
												}
												required: [
													"mountPath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										workingDir: type: "string"
									}
									required: [
										"name",
									]
									type: "object"
								}
								type: "array"
							}
							enforcedNamespaceLabel: type: "string"
							evaluationInterval: {
								default: "15s"
								pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
								type:    "string"
							}
							excludedFromEnforcement: {
								items: {
									properties: {
										group: {
											default: "monitoring.coreos.com"
											enum: [
												"monitoring.coreos.com",
											]
											type: "string"
										}
										name: type: "string"
										namespace: {
											minLength: 1
											type:      "string"
										}
										resource: {
											enum: [
												"prometheusrules",
												"servicemonitors",
												"podmonitors",
												"probes",
												"scrapeconfigs",
											]
											type: "string"
										}
									}
									required: [
										"namespace",
										"resource",
									]
									type: "object"
								}
								type: "array"
							}
							externalPrefix: type: "string"
							grpcServerTlsConfig: {
								properties: {
									ca: {
										properties: {
											configMap: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											secret: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
										}
										type: "object"
									}
									caFile: type: "string"
									cert: {
										properties: {
											configMap: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
											secret: {
												properties: {
													key: type: "string"
													name: type: "string"
													optional: type: "boolean"
												}
												required: [
													"key",
												]
												type:                    "object"
												"x-kubernetes-map-type": "atomic"
											}
										}
										type: "object"
									}
									certFile: type: "string"
									insecureSkipVerify: type: "boolean"
									keyFile: type: "string"
									keySecret: {
										properties: {
											key: type: "string"
											name: type: "string"
											optional: type: "boolean"
										}
										required: [
											"key",
										]
										type:                    "object"
										"x-kubernetes-map-type": "atomic"
									}
									serverName: type: "string"
								}
								type: "object"
							}
							hostAliases: {
								items: {
									properties: {
										hostnames: {
											items: type: "string"
											type: "array"
										}
										ip: type: "string"
									}
									required: [
										"hostnames",
										"ip",
									]
									type: "object"
								}
								type: "array"
								"x-kubernetes-list-map-keys": [
									"ip",
								]
								"x-kubernetes-list-type": "map"
							}
							image: type: "string"
							imagePullPolicy: {
								enum: [
									"",
									"Always",
									"Never",
									"IfNotPresent",
								]
								type: "string"
							}
							imagePullSecrets: {
								items: {
									properties: name: type: "string"
									type:                    "object"
									"x-kubernetes-map-type": "atomic"
								}
								type: "array"
							}
							initContainers: {
								items: {
									properties: {
										args: {
											items: type: "string"
											type: "array"
										}
										command: {
											items: type: "string"
											type: "array"
										}
										env: {
											items: {
												properties: {
													name: type: "string"
													value: type: "string"
													valueFrom: {
														properties: {
															configMapKeyRef: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															fieldRef: {
																properties: {
																	apiVersion: type: "string"
																	fieldPath: type: "string"
																}
																required: [
																	"fieldPath",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															resourceFieldRef: {
																properties: {
																	containerName: type: "string"
																	divisor: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	resource: type: "string"
																}
																required: [
																	"resource",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															secretKeyRef: {
																properties: {
																	key: type: "string"
																	name: type: "string"
																	optional: type: "boolean"
																}
																required: [
																	"key",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
														}
														type: "object"
													}
												}
												required: [
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										envFrom: {
											items: {
												properties: {
													configMapRef: {
														properties: {
															name: type: "string"
															optional: type: "boolean"
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													prefix: type: "string"
													secretRef: {
														properties: {
															name: type: "string"
															optional: type: "boolean"
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											type: "array"
										}
										image: type: "string"
										imagePullPolicy: type: "string"
										lifecycle: {
											properties: {
												postStart: {
													properties: {
														exec: {
															properties: command: {
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														httpGet: {
															properties: {
																host: type: "string"
																httpHeaders: {
																	items: {
																		properties: {
																			name: type: "string"
																			value: type: "string"
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																path: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
																scheme: type: "string"
															}
															required: [
																"port",
															]
															type: "object"
														}
														sleep: {
															properties: seconds: {
																format: "int64"
																type:   "integer"
															}
															required: [
																"seconds",
															]
															type: "object"
														}
														tcpSocket: {
															properties: {
																host: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
															}
															required: [
																"port",
															]
															type: "object"
														}
													}
													type: "object"
												}
												preStop: {
													properties: {
														exec: {
															properties: command: {
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														httpGet: {
															properties: {
																host: type: "string"
																httpHeaders: {
																	items: {
																		properties: {
																			name: type: "string"
																			value: type: "string"
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																path: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
																scheme: type: "string"
															}
															required: [
																"port",
															]
															type: "object"
														}
														sleep: {
															properties: seconds: {
																format: "int64"
																type:   "integer"
															}
															required: [
																"seconds",
															]
															type: "object"
														}
														tcpSocket: {
															properties: {
																host: type: "string"
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	"x-kubernetes-int-or-string": true
																}
															}
															required: [
																"port",
															]
															type: "object"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										livenessProbe: {
											properties: {
												exec: {
													properties: command: {
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													format: "int32"
													type:   "integer"
												}
												grpc: {
													properties: {
														port: {
															format: "int32"
															type:   "integer"
														}
														service: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												httpGet: {
													properties: {
														host: type: "string"
														httpHeaders: {
															items: {
																properties: {
																	name: type: "string"
																	value: type: "string"
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
														scheme: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												initialDelaySeconds: {
													format: "int32"
													type:   "integer"
												}
												periodSeconds: {
													format: "int32"
													type:   "integer"
												}
												successThreshold: {
													format: "int32"
													type:   "integer"
												}
												tcpSocket: {
													properties: {
														host: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
													}
													required: [
														"port",
													]
													type: "object"
												}
												terminationGracePeriodSeconds: {
													format: "int64"
													type:   "integer"
												}
												timeoutSeconds: {
													format: "int32"
													type:   "integer"
												}
											}
											type: "object"
										}
										name: type: "string"
										ports: {
											items: {
												properties: {
													containerPort: {
														format: "int32"
														type:   "integer"
													}
													hostIP: type: "string"
													hostPort: {
														format: "int32"
														type:   "integer"
													}
													name: type: "string"
													protocol: {
														default: "TCP"
														type:    "string"
													}
												}
												required: [
													"containerPort",
												]
												type: "object"
											}
											type: "array"
											"x-kubernetes-list-map-keys": [
												"containerPort",
												"protocol",
											]
											"x-kubernetes-list-type": "map"
										}
										readinessProbe: {
											properties: {
												exec: {
													properties: command: {
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													format: "int32"
													type:   "integer"
												}
												grpc: {
													properties: {
														port: {
															format: "int32"
															type:   "integer"
														}
														service: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												httpGet: {
													properties: {
														host: type: "string"
														httpHeaders: {
															items: {
																properties: {
																	name: type: "string"
																	value: type: "string"
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
														scheme: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												initialDelaySeconds: {
													format: "int32"
													type:   "integer"
												}
												periodSeconds: {
													format: "int32"
													type:   "integer"
												}
												successThreshold: {
													format: "int32"
													type:   "integer"
												}
												tcpSocket: {
													properties: {
														host: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
													}
													required: [
														"port",
													]
													type: "object"
												}
												terminationGracePeriodSeconds: {
													format: "int64"
													type:   "integer"
												}
												timeoutSeconds: {
													format: "int32"
													type:   "integer"
												}
											}
											type: "object"
										}
										resizePolicy: {
											items: {
												properties: {
													resourceName: type: "string"
													restartPolicy: type: "string"
												}
												required: [
													"resourceName",
													"restartPolicy",
												]
												type: "object"
											}
											type:                     "array"
											"x-kubernetes-list-type": "atomic"
										}
										resources: {
											properties: {
												claims: {
													items: {
														properties: name: type: "string"
														required: [
															"name",
														]
														type: "object"
													}
													type: "array"
													"x-kubernetes-list-map-keys": [
														"name",
													]
													"x-kubernetes-list-type": "map"
												}
												limits: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													type: "object"
												}
												requests: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													type: "object"
												}
											}
											type: "object"
										}
										restartPolicy: type: "string"
										securityContext: {
											properties: {
												allowPrivilegeEscalation: type: "boolean"
												capabilities: {
													properties: {
														add: {
															items: type: "string"
															type: "array"
														}
														drop: {
															items: type: "string"
															type: "array"
														}
													}
													type: "object"
												}
												privileged: type: "boolean"
												procMount: type: "string"
												readOnlyRootFilesystem: type: "boolean"
												runAsGroup: {
													format: "int64"
													type:   "integer"
												}
												runAsNonRoot: type: "boolean"
												runAsUser: {
													format: "int64"
													type:   "integer"
												}
												seLinuxOptions: {
													properties: {
														level: type: "string"
														role: type: "string"
														type: type: "string"
														user: type: "string"
													}
													type: "object"
												}
												seccompProfile: {
													properties: {
														localhostProfile: type: "string"
														type: type: "string"
													}
													required: [
														"type",
													]
													type: "object"
												}
												windowsOptions: {
													properties: {
														gmsaCredentialSpec: type: "string"
														gmsaCredentialSpecName: type: "string"
														hostProcess: type: "boolean"
														runAsUserName: type: "string"
													}
													type: "object"
												}
											}
											type: "object"
										}
										startupProbe: {
											properties: {
												exec: {
													properties: command: {
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													format: "int32"
													type:   "integer"
												}
												grpc: {
													properties: {
														port: {
															format: "int32"
															type:   "integer"
														}
														service: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												httpGet: {
													properties: {
														host: type: "string"
														httpHeaders: {
															items: {
																properties: {
																	name: type: "string"
																	value: type: "string"
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
														scheme: type: "string"
													}
													required: [
														"port",
													]
													type: "object"
												}
												initialDelaySeconds: {
													format: "int32"
													type:   "integer"
												}
												periodSeconds: {
													format: "int32"
													type:   "integer"
												}
												successThreshold: {
													format: "int32"
													type:   "integer"
												}
												tcpSocket: {
													properties: {
														host: type: "string"
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															"x-kubernetes-int-or-string": true
														}
													}
													required: [
														"port",
													]
													type: "object"
												}
												terminationGracePeriodSeconds: {
													format: "int64"
													type:   "integer"
												}
												timeoutSeconds: {
													format: "int32"
													type:   "integer"
												}
											}
											type: "object"
										}
										stdin: type: "boolean"
										stdinOnce: type: "boolean"
										terminationMessagePath: type: "string"
										terminationMessagePolicy: type: "string"
										tty: type: "boolean"
										volumeDevices: {
											items: {
												properties: {
													devicePath: type: "string"
													name: type: "string"
												}
												required: [
													"devicePath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										volumeMounts: {
											items: {
												properties: {
													mountPath: type: "string"
													mountPropagation: type: "string"
													name: type: "string"
													readOnly: type: "boolean"
													subPath: type: "string"
													subPathExpr: type: "string"
												}
												required: [
													"mountPath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										workingDir: type: "string"
									}
									required: [
										"name",
									]
									type: "object"
								}
								type: "array"
							}
							labels: {
								additionalProperties: type: "string"
								type: "object"
							}
							listenLocal: type: "boolean"
							logFormat: {
								enum: [
									"",
									"logfmt",
									"json",
								]
								type: "string"
							}
							logLevel: {
								enum: [
									"",
									"debug",
									"info",
									"warn",
									"error",
								]
								type: "string"
							}
							minReadySeconds: {
								format: "int32"
								type:   "integer"
							}
							nodeSelector: {
								additionalProperties: type: "string"
								type: "object"
							}
							objectStorageConfig: {
								properties: {
									key: type: "string"
									name: type: "string"
									optional: type: "boolean"
								}
								required: [
									"key",
								]
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							objectStorageConfigFile: type: "string"
							paused: type: "boolean"
							podMetadata: {
								properties: {
									annotations: {
										additionalProperties: type: "string"
										type: "object"
									}
									labels: {
										additionalProperties: type: "string"
										type: "object"
									}
									name: type: "string"
								}
								type: "object"
							}
							portName: {
								default: "web"
								type:    "string"
							}
							priorityClassName: type: "string"
							prometheusRulesExcludedFromEnforce: {
								items: {
									properties: {
										ruleName: type: "string"
										ruleNamespace: type: "string"
									}
									required: [
										"ruleName",
										"ruleNamespace",
									]
									type: "object"
								}
								type: "array"
							}
							queryConfig: {
								properties: {
									key: type: "string"
									name: type: "string"
									optional: type: "boolean"
								}
								required: [
									"key",
								]
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							queryEndpoints: {
								items: type: "string"
								type: "array"
							}
							replicas: {
								format: "int32"
								type:   "integer"
							}
							resources: {
								properties: {
									claims: {
										items: {
											properties: name: type: "string"
											required: [
												"name",
											]
											type: "object"
										}
										type: "array"
										"x-kubernetes-list-map-keys": [
											"name",
										]
										"x-kubernetes-list-type": "map"
									}
									limits: {
										additionalProperties: {
											anyOf: [{
												type: "integer"
											}, {
												type: "string"
											}]
											pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
											"x-kubernetes-int-or-string": true
										}
										type: "object"
									}
									requests: {
										additionalProperties: {
											anyOf: [{
												type: "integer"
											}, {
												type: "string"
											}]
											pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
											"x-kubernetes-int-or-string": true
										}
										type: "object"
									}
								}
								type: "object"
							}
							retention: {
								default: "24h"
								pattern: "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
								type:    "string"
							}
							routePrefix: type: "string"
							ruleNamespaceSelector: {
								properties: {
									matchExpressions: {
										items: {
											properties: {
												key: type: "string"
												operator: type: "string"
												values: {
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							ruleSelector: {
								properties: {
									matchExpressions: {
										items: {
											properties: {
												key: type: "string"
												operator: type: "string"
												values: {
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										type: "object"
									}
								}
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							securityContext: {
								properties: {
									fsGroup: {
										format: "int64"
										type:   "integer"
									}
									fsGroupChangePolicy: type: "string"
									runAsGroup: {
										format: "int64"
										type:   "integer"
									}
									runAsNonRoot: type: "boolean"
									runAsUser: {
										format: "int64"
										type:   "integer"
									}
									seLinuxOptions: {
										properties: {
											level: type: "string"
											role: type: "string"
											type: type: "string"
											user: type: "string"
										}
										type: "object"
									}
									seccompProfile: {
										properties: {
											localhostProfile: type: "string"
											type: type: "string"
										}
										required: [
											"type",
										]
										type: "object"
									}
									supplementalGroups: {
										items: {
											format: "int64"
											type:   "integer"
										}
										type: "array"
									}
									sysctls: {
										items: {
											properties: {
												name: type: "string"
												value: type: "string"
											}
											required: [
												"name",
												"value",
											]
											type: "object"
										}
										type: "array"
									}
									windowsOptions: {
										properties: {
											gmsaCredentialSpec: type: "string"
											gmsaCredentialSpecName: type: "string"
											hostProcess: type: "boolean"
											runAsUserName: type: "string"
										}
										type: "object"
									}
								}
								type: "object"
							}
							serviceAccountName: type: "string"
							storage: {
								properties: {
									disableMountSubPath: type: "boolean"
									emptyDir: {
										properties: {
											medium: type: "string"
											sizeLimit: {
												anyOf: [{
													type: "integer"
												}, {
													type: "string"
												}]
												pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
												"x-kubernetes-int-or-string": true
											}
										}
										type: "object"
									}
									ephemeral: {
										properties: volumeClaimTemplate: {
											properties: {
												metadata: type: "object"
												spec: {
													properties: {
														accessModes: {
															items: type: "string"
															type: "array"
														}
														dataSource: {
															properties: {
																apiGroup: type: "string"
																kind: type: "string"
																name: type: "string"
															}
															required: [
																"kind",
																"name",
															]
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														dataSourceRef: {
															properties: {
																apiGroup: type: "string"
																kind: type: "string"
																name: type: "string"
																namespace: type: "string"
															}
															required: [
																"kind",
																"name",
															]
															type: "object"
														}
														resources: {
															properties: {
																limits: {
																	additionalProperties: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	type: "object"
																}
																requests: {
																	additionalProperties: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	type: "object"
																}
															}
															type: "object"
														}
														selector: {
															properties: {
																matchExpressions: {
																	items: {
																		properties: {
																			key: type: "string"
																			operator: type: "string"
																			values: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	type: "object"
																}
															}
															type:                    "object"
															"x-kubernetes-map-type": "atomic"
														}
														storageClassName: type: "string"
														volumeAttributesClassName: type: "string"
														volumeMode: type: "string"
														volumeName: type: "string"
													}
													type: "object"
												}
											}
											required: [
												"spec",
											]
											type: "object"
										}
										type: "object"
									}
									volumeClaimTemplate: {
										properties: {
											apiVersion: type: "string"
											kind: type: "string"
											metadata: {
												properties: {
													annotations: {
														additionalProperties: type: "string"
														type: "object"
													}
													labels: {
														additionalProperties: type: "string"
														type: "object"
													}
													name: type: "string"
												}
												type: "object"
											}
											spec: {
												properties: {
													accessModes: {
														items: type: "string"
														type: "array"
													}
													dataSource: {
														properties: {
															apiGroup: type: "string"
															kind: type: "string"
															name: type: "string"
														}
														required: [
															"kind",
															"name",
														]
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													dataSourceRef: {
														properties: {
															apiGroup: type: "string"
															kind: type: "string"
															name: type: "string"
															namespace: type: "string"
														}
														required: [
															"kind",
															"name",
														]
														type: "object"
													}
													resources: {
														properties: {
															limits: {
																additionalProperties: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																	"x-kubernetes-int-or-string": true
																}
																type: "object"
															}
															requests: {
																additionalProperties: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																	"x-kubernetes-int-or-string": true
																}
																type: "object"
															}
														}
														type: "object"
													}
													selector: {
														properties: {
															matchExpressions: {
																items: {
																	properties: {
																		key: type: "string"
																		operator: type: "string"
																		values: {
																			items: type: "string"
																			type: "array"
																		}
																	}
																	required: [
																		"key",
																		"operator",
																	]
																	type: "object"
																}
																type: "array"
															}
															matchLabels: {
																additionalProperties: type: "string"
																type: "object"
															}
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													storageClassName: type: "string"
													volumeAttributesClassName: type: "string"
													volumeMode: type: "string"
													volumeName: type: "string"
												}
												type: "object"
											}
											status: {
												properties: {
													accessModes: {
														items: type: "string"
														type: "array"
													}
													allocatedResourceStatuses: {
														additionalProperties: type: "string"
														type:                    "object"
														"x-kubernetes-map-type": "granular"
													}
													allocatedResources: {
														additionalProperties: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
															"x-kubernetes-int-or-string": true
														}
														type: "object"
													}
													capacity: {
														additionalProperties: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
															"x-kubernetes-int-or-string": true
														}
														type: "object"
													}
													conditions: {
														items: {
															properties: {
																lastProbeTime: {
																	format: "date-time"
																	type:   "string"
																}
																lastTransitionTime: {
																	format: "date-time"
																	type:   "string"
																}
																message: type: "string"
																reason: type: "string"
																status: type: "string"
																type: type: "string"
															}
															required: [
																"status",
																"type",
															]
															type: "object"
														}
														type: "array"
													}
													currentVolumeAttributesClassName: type: "string"
													modifyVolumeStatus: {
														properties: {
															status: type: "string"
															targetVolumeAttributesClassName: type: "string"
														}
														required: [
															"status",
														]
														type: "object"
													}
													phase: type: "string"
												}
												type: "object"
											}
										}
										type: "object"
									}
								}
								type: "object"
							}
							tolerations: {
								items: {
									properties: {
										effect: type: "string"
										key: type: "string"
										operator: type: "string"
										tolerationSeconds: {
											format: "int64"
											type:   "integer"
										}
										value: type: "string"
									}
									type: "object"
								}
								type: "array"
							}
							topologySpreadConstraints: {
								items: {
									properties: {
										labelSelector: {
											properties: {
												matchExpressions: {
													items: {
														properties: {
															key: type: "string"
															operator: type: "string"
															values: {
																items: type: "string"
																type: "array"
															}
														}
														required: [
															"key",
															"operator",
														]
														type: "object"
													}
													type: "array"
												}
												matchLabels: {
													additionalProperties: type: "string"
													type: "object"
												}
											}
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										matchLabelKeys: {
											items: type: "string"
											type:                     "array"
											"x-kubernetes-list-type": "atomic"
										}
										maxSkew: {
											format: "int32"
											type:   "integer"
										}
										minDomains: {
											format: "int32"
											type:   "integer"
										}
										nodeAffinityPolicy: type: "string"
										nodeTaintsPolicy: type: "string"
										topologyKey: type: "string"
										whenUnsatisfiable: type: "string"
									}
									required: [
										"maxSkew",
										"topologyKey",
										"whenUnsatisfiable",
									]
									type: "object"
								}
								type: "array"
							}
							tracingConfig: {
								properties: {
									key: type: "string"
									name: type: "string"
									optional: type: "boolean"
								}
								required: [
									"key",
								]
								type:                    "object"
								"x-kubernetes-map-type": "atomic"
							}
							tracingConfigFile: type: "string"
							version: type: "string"
							volumeMounts: {
								items: {
									properties: {
										mountPath: type: "string"
										mountPropagation: type: "string"
										name: type: "string"
										readOnly: type: "boolean"
										subPath: type: "string"
										subPathExpr: type: "string"
									}
									required: [
										"mountPath",
										"name",
									]
									type: "object"
								}
								type: "array"
							}
							volumes: {
								items: {
									properties: {
										awsElasticBlockStore: {
											properties: {
												fsType: type: "string"
												partition: {
													format: "int32"
													type:   "integer"
												}
												readOnly: type: "boolean"
												volumeID: type: "string"
											}
											required: [
												"volumeID",
											]
											type: "object"
										}
										azureDisk: {
											properties: {
												cachingMode: type: "string"
												diskName: type: "string"
												diskURI: type: "string"
												fsType: type: "string"
												kind: type: "string"
												readOnly: type: "boolean"
											}
											required: [
												"diskName",
												"diskURI",
											]
											type: "object"
										}
										azureFile: {
											properties: {
												readOnly: type: "boolean"
												secretName: type: "string"
												shareName: type: "string"
											}
											required: [
												"secretName",
												"shareName",
											]
											type: "object"
										}
										cephfs: {
											properties: {
												monitors: {
													items: type: "string"
													type: "array"
												}
												path: type: "string"
												readOnly: type: "boolean"
												secretFile: type: "string"
												secretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												user: type: "string"
											}
											required: [
												"monitors",
											]
											type: "object"
										}
										cinder: {
											properties: {
												fsType: type: "string"
												readOnly: type: "boolean"
												secretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												volumeID: type: "string"
											}
											required: [
												"volumeID",
											]
											type: "object"
										}
										configMap: {
											properties: {
												defaultMode: {
													format: "int32"
													type:   "integer"
												}
												items: {
													items: {
														properties: {
															key: type: "string"
															mode: {
																format: "int32"
																type:   "integer"
															}
															path: type: "string"
														}
														required: [
															"key",
															"path",
														]
														type: "object"
													}
													type: "array"
												}
												name: type: "string"
												optional: type: "boolean"
											}
											type:                    "object"
											"x-kubernetes-map-type": "atomic"
										}
										csi: {
											properties: {
												driver: type: "string"
												fsType: type: "string"
												nodePublishSecretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												readOnly: type: "boolean"
												volumeAttributes: {
													additionalProperties: type: "string"
													type: "object"
												}
											}
											required: [
												"driver",
											]
											type: "object"
										}
										downwardAPI: {
											properties: {
												defaultMode: {
													format: "int32"
													type:   "integer"
												}
												items: {
													items: {
														properties: {
															fieldRef: {
																properties: {
																	apiVersion: type: "string"
																	fieldPath: type: "string"
																}
																required: [
																	"fieldPath",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															mode: {
																format: "int32"
																type:   "integer"
															}
															path: type: "string"
															resourceFieldRef: {
																properties: {
																	containerName: type: "string"
																	divisor: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	resource: type: "string"
																}
																required: [
																	"resource",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
														}
														required: [
															"path",
														]
														type: "object"
													}
													type: "array"
												}
											}
											type: "object"
										}
										emptyDir: {
											properties: {
												medium: type: "string"
												sizeLimit: {
													anyOf: [{
														type: "integer"
													}, {
														type: "string"
													}]
													pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
													"x-kubernetes-int-or-string": true
												}
											}
											type: "object"
										}
										ephemeral: {
											properties: volumeClaimTemplate: {
												properties: {
													metadata: type: "object"
													spec: {
														properties: {
															accessModes: {
																items: type: "string"
																type: "array"
															}
															dataSource: {
																properties: {
																	apiGroup: type: "string"
																	kind: type: "string"
																	name: type: "string"
																}
																required: [
																	"kind",
																	"name",
																]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															dataSourceRef: {
																properties: {
																	apiGroup: type: "string"
																	kind: type: "string"
																	name: type: "string"
																	namespace: type: "string"
																}
																required: [
																	"kind",
																	"name",
																]
																type: "object"
															}
															resources: {
																properties: {
																	limits: {
																		additionalProperties: {
																			anyOf: [{
																				type: "integer"
																			}, {
																				type: "string"
																			}]
																			pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																			"x-kubernetes-int-or-string": true
																		}
																		type: "object"
																	}
																	requests: {
																		additionalProperties: {
																			anyOf: [{
																				type: "integer"
																			}, {
																				type: "string"
																			}]
																			pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																			"x-kubernetes-int-or-string": true
																		}
																		type: "object"
																	}
																}
																type: "object"
															}
															selector: {
																properties: {
																	matchExpressions: {
																		items: {
																			properties: {
																				key: type: "string"
																				operator: type: "string"
																				values: {
																					items: type: "string"
																					type: "array"
																				}
																			}
																			required: [
																				"key",
																				"operator",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	matchLabels: {
																		additionalProperties: type: "string"
																		type: "object"
																	}
																}
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															storageClassName: type: "string"
															volumeAttributesClassName: type: "string"
															volumeMode: type: "string"
															volumeName: type: "string"
														}
														type: "object"
													}
												}
												required: [
													"spec",
												]
												type: "object"
											}
											type: "object"
										}
										fc: {
											properties: {
												fsType: type: "string"
												lun: {
													format: "int32"
													type:   "integer"
												}
												readOnly: type: "boolean"
												targetWWNs: {
													items: type: "string"
													type: "array"
												}
												wwids: {
													items: type: "string"
													type: "array"
												}
											}
											type: "object"
										}
										flexVolume: {
											properties: {
												driver: type: "string"
												fsType: type: "string"
												options: {
													additionalProperties: type: "string"
													type: "object"
												}
												readOnly: type: "boolean"
												secretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
											}
											required: [
												"driver",
											]
											type: "object"
										}
										flocker: {
											properties: {
												datasetName: type: "string"
												datasetUUID: type: "string"
											}
											type: "object"
										}
										gcePersistentDisk: {
											properties: {
												fsType: type: "string"
												partition: {
													format: "int32"
													type:   "integer"
												}
												pdName: type: "string"
												readOnly: type: "boolean"
											}
											required: [
												"pdName",
											]
											type: "object"
										}
										gitRepo: {
											properties: {
												directory: type: "string"
												repository: type: "string"
												revision: type: "string"
											}
											required: [
												"repository",
											]
											type: "object"
										}
										glusterfs: {
											properties: {
												endpoints: type: "string"
												path: type: "string"
												readOnly: type: "boolean"
											}
											required: [
												"endpoints",
												"path",
											]
											type: "object"
										}
										hostPath: {
											properties: {
												path: type: "string"
												type: type: "string"
											}
											required: [
												"path",
											]
											type: "object"
										}
										iscsi: {
											properties: {
												chapAuthDiscovery: type: "boolean"
												chapAuthSession: type: "boolean"
												fsType: type: "string"
												initiatorName: type: "string"
												iqn: type: "string"
												iscsiInterface: type: "string"
												lun: {
													format: "int32"
													type:   "integer"
												}
												portals: {
													items: type: "string"
													type: "array"
												}
												readOnly: type: "boolean"
												secretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												targetPortal: type: "string"
											}
											required: [
												"iqn",
												"lun",
												"targetPortal",
											]
											type: "object"
										}
										name: type: "string"
										nfs: {
											properties: {
												path: type: "string"
												readOnly: type: "boolean"
												server: type: "string"
											}
											required: [
												"path",
												"server",
											]
											type: "object"
										}
										persistentVolumeClaim: {
											properties: {
												claimName: type: "string"
												readOnly: type: "boolean"
											}
											required: [
												"claimName",
											]
											type: "object"
										}
										photonPersistentDisk: {
											properties: {
												fsType: type: "string"
												pdID: type: "string"
											}
											required: [
												"pdID",
											]
											type: "object"
										}
										portworxVolume: {
											properties: {
												fsType: type: "string"
												readOnly: type: "boolean"
												volumeID: type: "string"
											}
											required: [
												"volumeID",
											]
											type: "object"
										}
										projected: {
											properties: {
												defaultMode: {
													format: "int32"
													type:   "integer"
												}
												sources: {
													items: {
														properties: {
															clusterTrustBundle: {
																properties: {
																	labelSelector: {
																		properties: {
																			matchExpressions: {
																				items: {
																					properties: {
																						key: type: "string"
																						operator: type: "string"
																						values: {
																							items: type: "string"
																							type: "array"
																						}
																					}
																					required: [
																						"key",
																						"operator",
																					]
																					type: "object"
																				}
																				type: "array"
																			}
																			matchLabels: {
																				additionalProperties: type: "string"
																				type: "object"
																			}
																		}
																		type:                    "object"
																		"x-kubernetes-map-type": "atomic"
																	}
																	name: type: "string"
																	optional: type: "boolean"
																	path: type: "string"
																	signerName: type: "string"
																}
																required: [
																	"path",
																]
																type: "object"
															}
															configMap: {
																properties: {
																	items: {
																		items: {
																			properties: {
																				key: type: "string"
																				mode: {
																					format: "int32"
																					type:   "integer"
																				}
																				path: type: "string"
																			}
																			required: [
																				"key",
																				"path",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	name: type: "string"
																	optional: type: "boolean"
																}
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															downwardAPI: {
																properties: items: {
																	items: {
																		properties: {
																			fieldRef: {
																				properties: {
																					apiVersion: type: "string"
																					fieldPath: type: "string"
																				}
																				required: [
																					"fieldPath",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																			mode: {
																				format: "int32"
																				type:   "integer"
																			}
																			path: type: "string"
																			resourceFieldRef: {
																				properties: {
																					containerName: type: "string"
																					divisor: {
																						anyOf: [{
																							type: "integer"
																						}, {
																							type: "string"
																						}]
																						pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																						"x-kubernetes-int-or-string": true
																					}
																					resource: type: "string"
																				}
																				required: [
																					"resource",
																				]
																				type:                    "object"
																				"x-kubernetes-map-type": "atomic"
																			}
																		}
																		required: [
																			"path",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																type: "object"
															}
															secret: {
																properties: {
																	items: {
																		items: {
																			properties: {
																				key: type: "string"
																				mode: {
																					format: "int32"
																					type:   "integer"
																				}
																				path: type: "string"
																			}
																			required: [
																				"key",
																				"path",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	name: type: "string"
																	optional: type: "boolean"
																}
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															serviceAccountToken: {
																properties: {
																	audience: type: "string"
																	expirationSeconds: {
																		format: "int64"
																		type:   "integer"
																	}
																	path: type: "string"
																}
																required: [
																	"path",
																]
																type: "object"
															}
														}
														type: "object"
													}
													type: "array"
												}
											}
											type: "object"
										}
										quobyte: {
											properties: {
												group: type: "string"
												readOnly: type: "boolean"
												registry: type: "string"
												tenant: type: "string"
												user: type: "string"
												volume: type: "string"
											}
											required: [
												"registry",
												"volume",
											]
											type: "object"
										}
										rbd: {
											properties: {
												fsType: type: "string"
												image: type: "string"
												keyring: type: "string"
												monitors: {
													items: type: "string"
													type: "array"
												}
												pool: type: "string"
												readOnly: type: "boolean"
												secretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												user: type: "string"
											}
											required: [
												"image",
												"monitors",
											]
											type: "object"
										}
										scaleIO: {
											properties: {
												fsType: type: "string"
												gateway: type: "string"
												protectionDomain: type: "string"
												readOnly: type: "boolean"
												secretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												sslEnabled: type: "boolean"
												storageMode: type: "string"
												storagePool: type: "string"
												system: type: "string"
												volumeName: type: "string"
											}
											required: [
												"gateway",
												"secretRef",
												"system",
											]
											type: "object"
										}
										secret: {
											properties: {
												defaultMode: {
													format: "int32"
													type:   "integer"
												}
												items: {
													items: {
														properties: {
															key: type: "string"
															mode: {
																format: "int32"
																type:   "integer"
															}
															path: type: "string"
														}
														required: [
															"key",
															"path",
														]
														type: "object"
													}
													type: "array"
												}
												optional: type: "boolean"
												secretName: type: "string"
											}
											type: "object"
										}
										storageos: {
											properties: {
												fsType: type: "string"
												readOnly: type: "boolean"
												secretRef: {
													properties: name: type: "string"
													type:                    "object"
													"x-kubernetes-map-type": "atomic"
												}
												volumeName: type: "string"
												volumeNamespace: type: "string"
											}
											type: "object"
										}
										vsphereVolume: {
											properties: {
												fsType: type: "string"
												storagePolicyID: type: "string"
												storagePolicyName: type: "string"
												volumePath: type: "string"
											}
											required: [
												"volumePath",
											]
											type: "object"
										}
									}
									required: [
										"name",
									]
									type: "object"
								}
								type: "array"
							}
						}
						type: "object"
					}
					status: {
						properties: {
							availableReplicas: {
								format: "int32"
								type:   "integer"
							}
							conditions: {
								items: {
									properties: {
										lastTransitionTime: {
											format: "date-time"
											type:   "string"
										}
										message: type: "string"
										observedGeneration: {
											format: "int64"
											type:   "integer"
										}
										reason: type: "string"
										status: type: "string"
										type: type: "string"
									}
									required: [
										"lastTransitionTime",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
								"x-kubernetes-list-map-keys": [
									"type",
								]
								"x-kubernetes-list-type": "map"
							}
							paused: type: "boolean"
							replicas: {
								format: "int32"
								type:   "integer"
							}
							unavailableReplicas: {
								format: "int32"
								type:   "integer"
							}
							updatedReplicas: {
								format: "int32"
								type:   "integer"
							}
						}
						required: [
							"availableReplicas",
							"paused",
							"replicas",
							"unavailableReplicas",
							"updatedReplicas",
						]
						type: "object"
					}
				}
				required: [
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}]
