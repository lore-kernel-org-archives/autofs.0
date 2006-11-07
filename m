From: Ian Kent <raven@themaw.net>
Subject: Re: NFS+AUTOFS: Strange connections every 2 minutes
Date: Tue, 07 Nov 2006 20:46:21 +0800
Message-ID: <1162903581.18975.48.camel@localhost>
References: <20061107105134.3618b93b@notebook.chaosbringer.de>
	<1162901206.18975.40.camel@localhost>
	<20061107133602.692531bb@notebook.chaosbringer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20061107133602.692531bb@notebook.chaosbringer.de>
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
To: Julian Hagenauer <chaosbringer@gmx.de>
Cc: autofs@linux.kernel.org

On Tue, 2006-11-07 at 13:36 +0100, Julian Hagenauer wrote:
> > It could be something else but experience so far has shown that this is
> > caused by some process continually accessing mount points. Unless there
> > is other evidence I can only recommend you find the process that's
> > scanning the directory tree or trying to access your automount
> > directories and fix it.
> 
> Hi,
> thank you, that could really be the problem. Do you have any hind, how i could determine that process?

Not really, with version 4. Some investigation with "lsof" might help.

The pid of the requesting process has been added to the kernel
communications structure and is recorded in the debug log for version 5
for this very reason.

Ian
