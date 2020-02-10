wget -q --auth-no-challenge --user fsalaman --password Password123 --output-document - \
	'http://jenkins-gtsmex-toks1.router.default.svc.cluster.local/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)'
