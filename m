From: Jeffrey Layton <jtlayton@poochiereds.net>
Subject: Re: replicated mounts patch
Date: Tue, 19 Apr 2005 14:11:19 -0400
Message-ID: <1113934279.1274.61.camel@barsoom.rdu.redhat.com>
References: <1113875877.4581.15.camel@tleilax.poochiereds.net>
	<1113912312.1274.26.camel@barsoom.rdu.redhat.com>
	<Pine.LNX.4.62.0504200053250.8587@donald.themaw.net>
	<1113933871.1274.56.camel@barsoom.rdu.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1113933871.1274.56.camel@barsoom.rdu.redhat.com>
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

> > Does the parse_mount_string work for something like:
> > "host1 , host2	 ,host3,  host4:/this/dir"?
> 
> Yes. I've verified that it does. It even works for relatively strange
> stuff like:
> 
> host1(1),host2:/this/dir host3(5):/that/dir
> 
> Unspecified weights get assigned the value 65535.

Actually, correction -- it will not work with the embedded whitespace in
your line. If that is removed then it will work. The parser interprets
whitespace to be a separate 'entry'.

Essentially, I break the line into whitespace separated chunks, and then
parse each part in turn. Having whitespace preceding or following the
commas will cause this not to work correctly.

Does the current parser handle this correctly?

-- Jeff
