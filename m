From: Will Taber <wtaber@us.ibm.com>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Fri, 02 Dec 2005 11:35:19 -0500
Message-ID: <439077C7.9050300@us.ibm.com>
References: <20051116101740.GA9551@RAM> <17292.64892.680738.833917@segfault.boston.redhat.com> <1133315771.8978.65.camel@lade.trondhjem.org> <438E0C66.6040607@us.ibm.com> <1133384015.8974.35.camel@lade.trondhjem.org> <438E1A05.7000308@us.ibm.com> <Pine.LNX.4.63.0512011917010.3189@donald.themaw.net> <438F251B.7060602@us.ibm.com> <Pine.LNX.4.63.0512022059350.2070@donald.themaw.net> <17296.21777.592381.958840@segfault.boston.redhat.com> <Pine.LNX.4.63.0512022301280.2070@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0512022301280.2070@donald.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: Jeff Moyer <jmoyer@redhat.com>, Trond Myklebust <trond.myklebust@fys.uio.no>, Ram Pai <linuxram@us.ibm.com>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

Ian Kent wrote:

> 
> Good call. A single example is sufficient to refute my assertion.
> 
> But to focus the discussion, the goal is to identify that the calling 
> process is the one that holds the semaphore to justify releasing it. For 
> lookup it's easy as it's always called with it held. lookup_hash will 
> always call revalidate or lookup with the nameidata struct NULL and 
> so can be used to identify the semaphore ownership similar to the devfs 
> code Will mentioned. I don't think the other tests there are relevant to 
> autofs. The patch will require some rework but still the same general 
> idea.
> 
> Can you think of an example code path where __lookup_hash is called with a 
> non null nameidata struct which leads to autofs4 revalidate or lookup.
> 

It looks as though __lookup_hash is called from open_namei with the lock 
held and a nameidata structure.  It also looks as though LOOKUP_OPEN is 
set in the nameidata->flags so you should be able to identify this case. 
  No, that's not because lookup_open does a path_walk to get the parent 
without the lock.  So it looks as though if you have a nameidata 
structure and the flags have LOOKUP_OPEN and LOOKUP_CREATE set but not 
LOOKUP_PARENT, then you are holding the i_sem lock.  The devfs code 
ignores LOOKUP_OPEN.  I have to go right now and I am not sure if the 
checks are equivalent so I will leave that as an exercise for the reader.

Regards,
Will


Will
