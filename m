From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: making the mountpoints visible all the time (fwd)
Date: Fri, 21 Nov 2003 11:56:31 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FBE6DEF.5020202@zytor.com>
References: <Pine.LNX.4.33.0311211453250.6131-100000@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0311211453250.6131-100000@wombat.indigo.net.au>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>

Ian Kent wrote:
> 
> The above works that way without the update.
> 
> I'm not sure that a periodic update really gets us much. Since in most
> sites maps change infrequently.
> 
> On the other hand at work we run a cron every night on all our machines to
> trigger an update of the maps.
> 
> So I'm on the fence here?
> 

Oh yes, a lot of map types support querying "has a change occurred"
(usually in the form of a generation number, or in the case of a file
map, the mtime.)  This absolutely should be taken advantage of.

(For a program map, this complicates the protocol somewhat.  I don't
know necessarily of the best way to deal with that.  It needs some
thinking :)

	-hpa
