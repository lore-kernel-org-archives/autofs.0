From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: making the mountpoints visible all the time (fwd)
Date: Wed, 19 Nov 2003 08:45:22 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FBB9E22.8090309@zytor.com>
References: <Pine.LNX.4.33.0311191612420.24336-100000@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0311191612420.24336-100000@wombat.indigo.net.au>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>

Ian Kent wrote:
> 
> That sounds good a good idea for inclusion in 4.1.1 (I have quite a list
> already).
> 
> Move the decision on what the map contains to the program map implementer.
> That would be fairly straight forward to implement given that I have a
> placeholder function in each map module.
> 

Well, it's pretty much the only thing that makes sense, since a program 
map can inherently do "anything".

Pretty much ghosting implies that there are now two operations required 
of a map: key->data lookup (old), and enumerate all keys (new).

And of course autofs needs to deal with the consequences of the map 
changing underneath it.

	-hpa
