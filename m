From: Ian Kent <raven@themaw.net>
Subject: Current patch queue has been committed
Date: Wed, 02 Oct 2013 10:13:52 +0800
Message-ID: <1380680032.2286.14.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:date:content-type:mime-version
	:content-transfer-encoding; s=mesmtp; bh=8FNqZ2jbKCxsrucyYWvKCbn
	Dwzc=; b=qGz2VDX8HyitpvkK9g5cj5/3xF+zSOKotYV6zv7CGkLJXBDBs/csrbE
	RCaqJZT53Or0D7+LDXBpuke/cIIgjKVLeAMCK5PlOdvpg8x7Cdf1rI3orfIk3uHZ
	yep5HZrM+9GWV6svBSIZFK9nG77v8DZlrrOPIWGfjKA9SU7+qHK0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:date
	:content-type:mime-version:content-transfer-encoding; s=smtpout;
	 bh=8FNqZ2jbKCxsrucyYWvKCbnDwzc=; b=LMVL0yVgS+P+N2CNkK80icXEZ8BU
	mSWBB5tL/cCWxL7TI6dFb4l8Tl34fDPGle8hzxI2znOh5YM0Lm1K/LitM9Qp2YYu
	XpP49EtfnKrdHtW4Ormm337uLzVhu8QT2XdBd/1Dt5ai2IbSTR+VPzjx7y7Z9EnI
	w1Le/N2B+e7GDUY=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs <autofs@vger.kernel.org>

Hi all,

Just to let those of you with patches that were in the current queue, I
have committed then and pushed the changes to the autofs git repository.

Please have a look and let me know if there are any omissions or
mistakes.

Ian


