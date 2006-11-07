From: Julian Hagenauer <chaosbringer@gmx.de>
Subject: Re: NFS+AUTOFS: Strange connections every 2 minutes
Date: Tue, 7 Nov 2006 13:36:02 +0100
Message-ID: <20061107133602.692531bb@notebook.chaosbringer.de>
References: <20061107105134.3618b93b@notebook.chaosbringer.de>
	<1162901206.18975.40.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1162901206.18975.40.camel@localhost>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

> It could be something else but experience so far has shown that this is
> caused by some process continually accessing mount points. Unless there
> is other evidence I can only recommend you find the process that's
> scanning the directory tree or trying to access your automount
> directories and fix it.

Hi,
thank you, that could really be the problem. Do you have any hind, how i could determine that process?
Thank you,
Julian
