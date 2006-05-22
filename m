From: Daniel Qarras <dqarras@yahoo.com>
Subject: Re: AutoFS Problems with Laptops
Date: Mon, 22 May 2006 00:53:27 -0700 (PDT)
Message-ID: <20060522075327.23988.qmail@web36807.mail.mud.yahoo.com>
References: <Pine.LNX.4.64.0605192133390.4364@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605192133390.4364@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Hi Ian,

and thanks for your prompt reply.

> > I am asking this because I've tried almost everything and I am just
> > getting bizarre results like directory /var/autofs/(null)/home,
> -------------------------------------------------------^
> You'd be running FC5 then.
> Can't track this down, we shouldn't be getting mount requests from
> the kernel with no name.

Yes, the client is FC5, the server is CentOS-4.4. At the server only
/etc/exports is configured like this:

/home           10.0.0.0/255.0.0.0(rw,no_root_squash,sync)
/work           10.0.0.0/255.0.0.0(rw,no_root_squash,sync)

> A script should just output the map entry without the key. Like
> -fstype=nfs,rw,soft,intr 10.0.0.1:/work

Unfortunately, this still creates (null) directory and I can even go to
/var/autofs/whatever to see contents of /work. And if the script
outputs both /work and /home I see only either of them, depending the
order the entries are printed and if they are on the same line or in
two lines.

Do you think I should file a bug to RH Bugzilla about this? It is
currently down so I cannot check whether there is already a report or
two about this issue. I posted this question also to Fedora list but
got no reply.

Thanks.



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
