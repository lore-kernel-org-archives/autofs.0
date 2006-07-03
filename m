From: Ian Kent <raven@themaw.net>
Subject: Re: autofs5: unable to locate ldap master map
Date: Tue, 04 Jul 2006 00:30:52 +0800
Message-ID: <1151944252.9183.46.camel@raven.themaw.net>
References: <44A25311.2040501@inria.fr>
	<1151554184.2929.45.camel@raven.themaw.net> <44A3B6CD.5030403@inria.fr>
	<1151585997.3915.36.camel@raven.themaw.net> <44A4E38D.7020004@inria.fr>
	<Pine.LNX.4.64.0607020143300.11953@raven.themaw.net>
	<44A9216F.1030102@inria.fr> <1151943337.9183.44.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1151943337.9183.44.camel@raven.themaw.net>
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
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Tue, 2006-07-04 at 00:15 +0800, Ian Kent wrote:
> > > Configure syslog to send deamon.* somewhere.
> > > The output is meant for debuging purposes and is possibly not that 
> > > meaninful to most. You will be expected to provide it you have a 
> > > bug that you would us to try and fix.
> > I was refering to log content.
> > With a wrong setup, launching automount without -d -v produces 3 lines
> > out output:
> > Jul  3 15:19:46 alceste automount[32750]: parse_ldap_config:
> > lookup(ldap): stat(2) failed with error No such file or directory.
> > Jul  3 15:19:46 alceste automount[32750]: lookup_init: lookup(ldap):
> > failed to get query dn
> > Jul  3 15:19:46 alceste automount[32750]: master_read_master: can't read
> > master map auto.master
> > 
> > With those additional -d -v flags, it just produce one additional line:
> > Jul  3 15:19:33 alceste automount[32741]: Starting automounter version
> > 5.0.0_beta6, master map auto.master
> > Jul  3 15:19:33 alceste automount[32741]: parse_ldap_config:
> > lookup(ldap): stat(2) failed with error No such file or directory.
> > Jul  3 15:19:33 alceste automount[32741]: lookup_init: lookup(ldap):
> > failed to get query dn
> > Jul  3 15:19:33 alceste automount[32741]: master_read_master: can't read
> > master map auto.master
> > 
> > But I guess there is not many more information to display.
> 
> But in beta6 I check if this file exists and return values as though
> everything is disabled. It should work. I'll do some more testing but
> are you sure that you got beta6 installed ok?

Thanks for your persistence.
I have indeed made a mistake with the check for existence of this file.
I'll fix it and get a patch onto kernel.org.

Ian
