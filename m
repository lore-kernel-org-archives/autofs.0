From: Erich Weiler <weiler@soe.ucsc.edu>
Subject: Re: automounter w/ LDAP redundant servers
Date: Thu, 03 Aug 2006 07:48:52 -0700
Message-ID: <44D20CD4.8030700@soe.ucsc.edu>
References: <44D0088A.2090009@soe.ucsc.edu>	
	<1154545348.26912.3.camel@raven.themaw.net>
	<44D129DF.20004@soe.ucsc.edu>
	<1154578630.6629.1.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1154578630.6629.1.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Er, as soon as I turned on debugging to debug it, it magically started 
working.  Automatically looked to the second server when I turned off 
slapd on the first...  Not sure why it wasn't working before...  Feel a 
little sheepish...  Maybe I rebooted the machine after the change had 
been made or something...  <grumble>

Oh well, I guess it was something weird I was doing that I wasn't aware 
of...  Thanks for chiming in in any case!

ciao, erich

Ian Kent wrote:
> On Wed, 2006-08-02 at 15:40 -0700, Erich Weiler wrote:
>>> So
>>> ldap://server1 server2/.....
>>>
>>> should work since the ldap_init call, I believe, will take such an
>>> argument. But then we need to check that autofs isn't getting in the
>>> road when it reads the ldap string to start with.
>> Sounds fantastic!  How can we check that?  :)
> 
> I think that putting more than one server in and running autofs with the
> debug option then checking the log may reveal what we need.
> 
> Ian
