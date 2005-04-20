From: Ian Kent <raven@themaw.net>
Subject: Re: replicated mounts patch
Date: Wed, 20 Apr 2005 09:25:46 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0504200922220.7460@wombat.indigo.net.au>
References: <1113875877.4581.15.camel@tleilax.poochiereds.net> 
	<1113912312.1274.26.camel@barsoom.rdu.redhat.com> 
	<Pine.LNX.4.62.0504200053250.8587@donald.themaw.net>
	<1113941787.1274.84.camel@barsoom.rdu.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1113941787.1274.84.camel@barsoom.rdu.redhat.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeffrey Layton <jtlayton@poochiereds.net>
Cc: autofs@linux.kernel.org

On Tue, 19 Apr 2005, Jeffrey Layton wrote:

> On Tue, 2005-04-19 at 12:58, raven@themaw.net wrote:
> > Does the parse_mount_string work for something like:
> > "host1 , host2	 ,host3,  host4:/this/dir"?
> > 
> 
> Just for yuks, I tested the above map style with the Solaris 8
> automounter. It does not seem to accept whitespace next to commas
> either.

But, I've had complaints about it in the past.
Call it an added feature.

If we choose to not require it we will need to be clear about it in the 
doco. 

Personally, I like to be able to add a space after each comma for 
readability.

Ian
