From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Quick question about parsing
Date: Thu, 28 Apr 2005 14:12:58 -0400
Message-ID: <17009.10154.689020.532687@segfault.boston.redhat.com>
References: <20050428142948.GP7317@lenin.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050428142948.GP7317@lenin.net>
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
To: "Peter C. Norton" <spacey-autofs@lenin.net>
Cc: autofs mailing list <autofs@linux.kernel.org>

==> Regarding [autofs] Quick question about parsing; "Peter C. Norton" <spacey-autofs@lenin.net> adds:

spacey-autofs> Does anyone know if there's a documented behaviour if the
spacey-autofs> same key appears more than once in a map?  First, last, all?

spacey-autofs> I'm trying to fix an issue in the NIS+ module, and I want to
spacey-autofs> make sure I'm doing what the documentation says I should.

Well, I don't believe NIS guarantees the order in which results are
returned.  I'm not sure about NIS+.

The internal behaviour of the Linux automounter is that all of the entries
are cached, but the first to be found is the one that is used.  Note that
this is all hidden under the covers from the various lookup modules.  So,
you shouldn't have to do anything specific in the nis+ module.

-Jeff
