From: "Mick" <email_mick_groups@bigpond.com>
Subject: RE: no auto in autofs...
Date: Thu, 2 Sep 2004 08:33:25 +0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <JCEBJEOKALMICCBFAFIBEEIMCFAA.email_mick_groups@bigpond.com>
References: <Pine.LNX.4.58.0409011429090.6576@vulture.rentec.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <Pine.LNX.4.58.0409011429090.6576@vulture.rentec.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Ryan Go <ryan@rentec.com>, Mick <email_mick_groups@bigpond.com>
Cc: autofs@linux.kernel.org

> Default behavior of autofs is not to mount unless you need it. Mkdir is
> probably doing some kind of stat as part of it's normal routine. Executing
> 'cd /misc/beast' would also trigger a mount.
>
Wierd, as per all the docs I've seen "ls -l" also does some kind of stat.

> If you want to see all your automount-points, there are options like
> browsing (I am not sure since I don't use them). There has been a lot of
> discussion about it in the past, try to search the list archives.
>
I would have, but the only list archives I've seen are not searchable?  Can
you point me int he right direction?

Mick
