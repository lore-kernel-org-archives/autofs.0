From: "Stephen Biggs" <sbiggs@nvidia.com>
Subject: Re: clients suddenly start hanging (was: (no subject))
Date: Tue, 24 Jun 2008 10:02:08 -0700
Message-ID: <A2ECBF49F352C24F9DF65BB529DCBC70187A5782@hqemmail01.nvidia.com>
References: <20080423185018.122C53C3B1@xena.cft.ca.us><1213414942.18072.26.camel@raven.themaw.net><1213845274.2971.11.camel@raven.themaw.net><20080619183446.532D82111B1@simba.math.ucla.edu><1213934961.2971.69.camel@raven.themaw.net><Pine.LNX.4.64.0806201713350.13828@xena.cft.ca.us><1214017944.4975.60.camel@raven.themaw.net><Pine.LNX.4.64.0806222024150.18218@xena.cft.ca.us><1214196368.3098.41.camel@raven.themaw.net>
	<1214276906.12623.88.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1214276906.12623.88.camel@raven.themaw.net>
Content-class: urn:content-classes:message
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
To: Ian Kent <raven@themaw.net>, Jim Carter <jimc@math.ucla.edu>
Cc: autofs@linux.kernel.org

> -----Original Message-----
> From: autofs-bounces@linux.kernel.org 
> [mailto:autofs-bounces@linux.kernel.org] On Behalf Of Ian Kent
> Sent: Monday, June 23, 2008 8:08 PM
> To: Jim Carter
> Cc: autofs@linux.kernel.org
> Subject: Re: [autofs] clients suddenly start hanging (was: 
> (no subject))

-- snip --

> Looks to me like I need to check if there is an expire or 
> prune already running and issue a message saying that and 
> ignore the signal.
> 
> This could be the expire still waiting on the blocked 
> umount(8). This is a bit of a problem because RPC won't give 
> up trying to send if it thinks there is an outstanding write. 
> We will need to investigate this further later as I don't 
> think it is specifically related to the submount issue.
> 

It isn't.  We are encountering this and we are not using submounts.
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
