From: Ricardo =?ISO-8859-1?Q?P=E9rez_L=F3pez?= <ricpelo@gmail.com>
Subject: Mount /home/* directories only with the right user
Date: Mon, 02 Aug 2010 13:15:53 +0200
Message-ID: <1280747753.4433.8.camel@kadath>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:subject:from:to:content-type
	:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	bh=Do8Pc/OX5rYiXU0AGDooDnhfUD1M1RnWaJ2k33epx6U=;
	b=D9ey4jEHJ89w/3AfLYXGepjjmdLLBRB8zl4zuHzmIOQ0nx9o+bVLLpmVVYmXIF8/go
	2UqelzBFIfhGJSA7JYbaQZjElxQ+68Sj9K0xaXr95NItysxIdJ0OIfGWXHXG6V9zzabi
	0lj96uQKOgEKQDusPmOJHb7tFdHGFnsBQszVI=
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

Hi. I'm an autofs newbie and I would like to ask you one question
related with the automounting of /home/* directories.

I've an NFS server exporting /home, and I've configured autofs5 in the
client computer in order to automount /home/* directories every time a
user is logged in (user accounts are exported via LDAP, but that's
another story).

When user (say) alice logs into the client computer, autofs exports
her /home/alice, so it's right. However, if alice now do:
"cd /home/bob", then autofs exports /home/bob too. I don't want that. I
wonder if there's a way to automount a /home/* directory ONLY if you're
the right user, i.e. alice should only get /home/alice and bob should
only get /home/bob.

(For another unrelated question, all the /home/* directories must have
777 permissions, so I'm trying to securize the access to the /home/*
directories using automount.)

Thanks in advance,

Ricardo.
