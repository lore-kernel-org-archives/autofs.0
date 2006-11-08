From: Michael Blandford <mlblandf@sedona.ch.intel.com>
Subject: Re: autofs illustrations
Date: Wed, 08 Nov 2006 08:32:20 -0700
Message-ID: <4551F884.4080301@sedona.ch.intel.com>
References: <200611071719.kA7HJSvl002639@cs.utexas.edu>
	<4550EF23.4050901@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4550EF23.4050901@redhat.com>
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
To: Peter Staubach <staubach@redhat.com>
Cc: autofs@linux.kernel.org

Peter Staubach wrote:

>Fletcher Mattox wrote:
>  
>
>>Jeff Moyer writes:
>>
>>
>>Unprivileged ports and/or UDP are not viable options for us, so I am
>>forced to increase the timeout from 5 minutes to 24 hours, which in
>>practice means they are always mounted.  We have about 400 automounted
>>filesystems, so the only long term solution for us is to try to coalesce
>>them to less than 100.  Very painful.
>>    
>>
>
>You have 400 automounted file systems, all of which need to be mounted at
>the same time?  If so, I might suggest that static mounts might better serve
>your needs.  Or, rethink the application and deployment.
>
>  
>


There are definitely two cases here.

1) There are going to be environments that are set up without much 
thought of the future.  You may have 400 mounts that you need for  a 
project all at one time because of small filesystems, inefficient 
layout, etc.  There may be only 400 mounts on the file server or servers.

2) There are projects/environments that have several thousands ( > 10k ) 
of filesystems that are layed out efficiently but still require more 
than > 1000 mounts at any given moment due to the large data requirements.

Either way, we need autofs and the NFS subsystem be able to handle 
this.  Many of the other UNIX vendors seems to handle this situation well.

Some Linux vendors already include patches to multiplex rpc to allow > 
1000 mounts.  However, the issue of quickly mounting hundreds/thousands 
of mounts is still a challenge - especially with NFS over TCP.

As a temporary solution, we have added a new option to the mount command 
to allow it to use udp for the handshaking and then only use tcp for the 
final mount.  This allows us to handle many more simultaneous mounts but 
it definitely a hack and won't work for people who can only use tcp.


Michael
