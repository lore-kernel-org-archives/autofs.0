From: Ian Kent <raven@themaw.net>
Subject: Re: Performance of autofs/amd-managed directory
Date: Wed, 26 May 2004 13:28:58 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405261326040.20880@wombat.indigo.net.au>
References: <20040526030234.47115.qmail@web20025.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040526030234.47115.qmail@web20025.mail.yahoo.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kenny Simpson <theonetruekenny@yahoo.com>
Cc: autofs@linux.kernel.org

On Tue, 25 May 2004, Kenny Simpson wrote:

> What is the performance penalty for write access to files in a managed
> directory vs. a fstab entry?
> I have a program that is very sensitive to write latency, and am being
> pressured to use amd or automount to access a NAS instead of my trusty fstab
> entry.

autofs only performes the mounts on demand not much more.

Once the mount is done autofs knows is completely out of the way as far as 
mounted filesystem access is concerned.

> 
> My app uses a transactional log file that resides on a NAS.  I'd prefer to keep
> a simple fstab entry and use O_DIRECT to access the file, but if there is no
> penalty, I would switch.  Does O_DIRECT have meaning for automount or
> amd-managed files?  (isn't amd user-space, so it would need to copy data
> anyway?)

I don't know about the amd design and its overhead, sorry.

Ian
