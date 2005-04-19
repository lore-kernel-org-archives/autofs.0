From: Jeffrey Layton <jtlayton@poochiereds.net>
Subject: Re: replicated mounts patch
Date: Tue, 19 Apr 2005 16:16:27 -0400
Message-ID: <1113941787.1274.84.camel@barsoom.rdu.redhat.com>
References: <1113875877.4581.15.camel@tleilax.poochiereds.net>
	<1113912312.1274.26.camel@barsoom.rdu.redhat.com>
	<Pine.LNX.4.62.0504200053250.8587@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0504200053250.8587@donald.themaw.net>
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
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: autofs@linux.kernel.org

On Tue, 2005-04-19 at 12:58, raven@themaw.net wrote:
> Does the parse_mount_string work for something like:
> "host1 , host2	 ,host3,  host4:/this/dir"?
> 

Just for yuks, I tested the above map style with the Solaris 8
automounter. It does not seem to accept whitespace next to commas
either.
-- Jeff
