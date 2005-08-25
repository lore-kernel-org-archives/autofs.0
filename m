From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Cascading/recursive autofs mounts?
Date: Thu, 25 Aug 2005 16:44:14 -0400
Message-ID: <17166.11678.314365.509696@segfault.boston.redhat.com>
References: <20050825201342.GB4935@neu.nirvana>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050825201342.GB4935@neu.nirvana>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

==> Regarding [autofs] Cascading/recursive autofs mounts?; Axel Thimm <Axel.Thimm@atrpms.net> adds:

Axel.Thimm> Hi, we have a setup, where we would like to have autofs mount
Axel.Thimm> over NFS a certain folder and then bind-mount from subfolders
Axel.Thimm> to other places.

Axel.Thimm> Can this work with autofs? E.g. can autofs cascade mount
Axel.Thimm> requests?  E.g. if the first autofs request would require a
Axel.Thimm> second one to be performed first, would the second one properly
Axel.Thimm> mount the NFS share and the outer one continue with bind
Axel.Thimm> mounting?. It looks like the first one would lock
Axel.Thimm> /var/lock/autofs and the inner autofs request would fail.

Correct.  The way things are structured in autofs4.1.4, recursive mounts
such as this are not supported.

-Jeff
