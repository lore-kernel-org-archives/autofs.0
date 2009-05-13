From: Ian Kent <raven@themaw.net>
Subject: Re: unable to automount windows C$
Date: Wed, 13 May 2009 13:30:50 +0800
Message-ID: <4A0A5B0A.1060701@themaw.net>
References: <9728fb580812101149s300c524dn5f6785c16bac969c@mail.gmail.com>	<1230012791.3043.6.camel@zeus.themaw.net>	<4A07749D.4000406@edcint.co.nz>
	<4A08FEE6.7000604@themaw.net>	<4A0A533A.3060203@edcint.co.nz>
	<4A0A5527.2060207@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A0A5527.2060207@themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Matthew Jurgens <autofs@edcint.co.nz>
Cc: autofs@linux.kernel.org, Jeff Layton <jlayton@redhat.com>

Ian Kent wrote:
>> May 13 14:43:28 gw automount[15573]: mount_mount: mount(generic):
>> calling mount -t cifs -s -o username=USERNAME,password=PASSWORD
>> //xp0/C\$ /tmp/auto6t8L4W

Ohh, I get it, the "\" is a path separator for mount.cifs and I think
the handling of it may have changed recently ish.

So catch 22, autofs must escaped the "$" to prevent it being interpreted
as a macro and the generic mount module has no special knowledge of cifs
so it can't do anything about it. Worse, since "\" is a valid path
separator for UNC paths we can't just check the fs type and translate
them all. For example, what if we get :\\\\<server>\\service as the
location?

Ian
