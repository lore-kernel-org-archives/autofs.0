From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs LDAP mount question
Date: Fri, 12 Mar 2010 13:02:21 +0800
Message-ID: <1268370141.2495.19.camel@localhost>
References: <dc3ecf561003102100h572cb015l5654ca179028795e@mail.gmail.com>
	<1268288881.2247.17.camel@localhost>
	<dc3ecf561003111732l683d852cg60e5c6db379273fa@mail.gmail.com>
	<1268362110.2495.7.camel@localhost>
	<dc3ecf561003112040p53d5beb7xd5360ee04bf46a56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=5sdra1v3xjl5tMsX4qKh/q75lgM=;
	b=tppKySQFdB/Xn5p4blkkvHdo23Fen6wjdEysbqVz60lt2a3ZwGuPhaMuDCcWdKduUPUY1MVF6LEs3b+bxAEnzqD1tOIloKenRxO2jHUrKOJ800xnvG3QCG7v0ekox6JIwvEGuCOJxBZ6p+51NerV1exRLn0oiuMOW1h370rgeDY=
In-Reply-To: <dc3ecf561003112040p53d5beb7xd5360ee04bf46a56@mail.gmail.com>
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
To: Techie <techchavez@gmail.com>
Cc: autofs@linux.kernel.org

On Thu, 2010-03-11 at 21:40 -0700, Techie wrote:
> On Thu, Mar 11, 2010 at 7:48 PM, Ian Kent <raven@themaw.net> wrote:
> > On Thu, 2010-03-11 at 18:32 -0700, Techie wrote:
> >> On Wed, Mar 10, 2010 at 11:28 PM, Ian Kent <raven@themaw.net> wrote:
> >> > On Wed, 2010-03-10 at 22:00 -0700, Techie wrote:
> >> >> Hello,
> >> >>
> >> >> I have a simple question regarding LDAP direct map mounts.
> >> >>
> >> >> If I use a local direct map "/etc/direct_map"  with the below contents
> >> >> to map NFS directories on two different file systems.
> >> >>
> >> >> /data                                    red:/usr/local/app   \
> >> >>          /libs/apps                    red:/var/libs/apps
> >> >>
> >> >> Both mount points to map properly. The /data directory shows the
> >> >> correct contents of red:/usr/local/app. And the /data/lib/apps
> >> >> directory also shows the correct contents of  red:/var/libs/apps. This
> >> >> is what I believe are nested mount points. However when I try the same
> >> >> thing with an LDAP direct map it fails. he contents of the same map in
> >> >> LDAP is below.
> >> >>
> >> >> dn: automountKey=/data,automountMapName=direct_map,ou=Autofs,dc=example,dc=com
> >> >> automountInformation: -fstype=nfs,rw red:/usr/local/app
> >> >> automountKey: /data
> >> >> objectClass: automount
> >> >> objectClass: top
> >> >>
> >> >> dn: automountKey=/data/libs/apps,automountMapName=direct_map,ou=Autofs,dc=example,dc=com
> >> >> automountKey: /data/libs/apps
> >> >> objectClass: automount
> >> >> objectClass: top
> >> >> automountInformation: -fstype=nfs,rw red://var/libs/apps
> >> >>
> >> >>
> >> >> When I do this in my LDAP map as shown above, the mount points do not
> >> >> show up correctly. The /data directory covers up one of the 2 mount
> >> >> points. So it looks like nested mount points don't work in LDAP or I
> >> >> am not using correct syntax. All my other LDAP mounts work but two
> >> >> mount points in the same dir does not work like it does with local
> >> >> direct maps.
> >> >>
> >> >> Can you please confirm or deny if I can achieve nested mount points
> >> >> using LDAP direct maps like I can with local direct maps as shown
> >> >> above?
> >> >
> >> > LDAP map isn't quite right.
> >> >
> >> > The LDAP map entry must be the same as your file map.
> >> >
> >> > In your file map the direct mount is
> >> > key = "/data"
> >> > location = "/ red:/usr/local/app /libs/apps red:/var/libs/apps"
> >> >
> >> > In your original file map the "/" offset has been implied because the
> >> > syntax allows it to be optional.
> >> >
> >> > and in LDAP
> >> > key = "/data"
> >> > location = "red:/usr/local/app"
> >> >
> >> > key = "/data/libs/apps"
> >> > Invalid, you can't nest distinct direct mounts.
> >> >
> >> > You need to use the same value for location as you did for the file map
> >> > in LDAP.
> >> >
> >> >>
> >> >>
> >> >> Thank you
> >> >>
> >> >> _______________________________________________
> >> Ian,
> >> Thanks a bunch for pointing out that the "/" offset is syntactically
> >> optional for file based maps but is necessary in LDAP. That really
> >> helped my understanding of both formats..
> >
> > No, actually it's always optional but can cause confusion when omitted.
> >
> > The issue was that you can't break up the mount location into two
> > separate entries (either in a file map or LDAP, LDAP convention just
> > happens to make you want to do it that way). You just need to feed the
> > same string to the daemon whether the map is in a file or stored in
> > LDAP.
> >
> > Ian
> >
> 
> I see that makes sense, thank you.
> I was also trying to specify multiple direct maps in LDAP. I tried
> creating another direct map with a "/-" key but ldap complained saying
> that the "/-" key already exists. Which makes sense as the two DNs
> would be the same.
> 
> In a /etc/auto.master local file I can have multiple direct map entries with ...
> /-   /etc/map1
> /-   /etc/map2
> 
> I was able to accomplish this in ldap by appending multiple map names
> to the automountinformation attribute of the dn: automountKey=/-
> entry. I am not sure if this is the proper way to do however it seems
> to work well so I imagine it may be. I am able to use the different
> maps by specifying them by name in the client auto.master files.
> AutoFS5 seems to be able to do everything I need it to, it's greatly
> improved over Autofs4 from what I can tell.

Yes, that is a limitation of ldap, bummer.

It is interesting to hear placing multiple map names in the
automountinformation attribute works for you, I didn't expect that would
work. I thought we would need to use a file or NIS based master map to
specify multiple direct map entries or use a schema that doesn't enforce
uniqueness and somehow name the dn a little differently.

Ian
