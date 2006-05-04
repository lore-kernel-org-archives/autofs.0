From: "Rigler, Stephen C." <srigler@marathonoil.com>
Subject: RE: [ANNOUNCE] autofs 5.0.0 beta1
Date: Thu, 4 May 2006 08:08:58 -0500
Message-ID: <C3CDA0E3AC8B4E438E94F37D0A20FE71026B10D2@HOUEXC210.mgroupnet.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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
Cc: autofs mailing list <autofs@linux.kernel.org>

 

> -----Original Message-----
> From: Ian Kent [mailto:raven@themaw.net] 
> Sent: Thursday, May 04, 2006 7:29 AM
> To: Rigler, Stephen C.
> Cc: autofs mailing list
> Subject: RE: [autofs] [ANNOUNCE] autofs 5.0.0 beta1
> 
> What do you have in the nsswitch.conf automount: entry?

I had "automount: files nis"

> 
> You probably already know this but ...
> 
> The default master map is /etc/auto.master but that can be changed by 
> setting DEFAULT_MASTER_MAP_NAME in the config or giving it on 
> the command 
> line for automount.
> 
> Setting
> 
> DEFAULT_MASTER_MAP_NAME=auto.master
> 
> and
> 
> automount: nis
> 
> should do the trick.
> 
> However if you had
> 
> automount: files nis
> 

So far, the combination that's worked is only specifying "nis"
in nsswitch.conf and changing "DEFAULT_MASTER_MAP_NAME" to
"auto.master".  What's logged in messages when I use any other
combination is "master_read_master: no mounts in table".

-Steve
