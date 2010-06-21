From: Chris Quenelle <chris.quenelle@oracle.com>
Subject: two /net paths to the same local mount?
Date: Mon, 21 Jun 2010 12:17:19 -0700
Message-ID: <4C1FBABF.5060207@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

When I use /net/host and /net/host.domain to access a file system
that is local to the current host, the second flavor of access will
hang.

We have a complex build environment running on multiple hosts,
so directory names often need to work either locally or remotely.
That's why we're using /net paths for the local host.

Is this a known bug?

I can supply more details, if necessary.
Rebuilding from source is not really practical in my environment.

--chris
