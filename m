From: Ian Kent <raven@themaw.net>
Subject: Re: [ANNOUNCE] autofs 5.0.0 beta4 another beta release
Date: Mon, 5 Jun 2006 12:31:55 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0606051224450.27003@raven.themaw.net>
References: <Pine.LNX.4.63.0606042223580.12192@jpro.nerc-bas.ac.uk>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0606042223580.12192@jpro.nerc-bas.ac.uk>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jpro@bas.ac.uk
Cc: autofs mailing list <autofs@linux.kernel.org>

On Sun, 4 Jun 2006, jpro@bas.ac.uk wrote:

> Hi,
> 
> > I think we are getting close to a release but we need more testing in more
> > areas on this or we will be stuck with annoying bugs in the v5 release for
> > longer than we should.
> 
> I've just started looking at autofs v5 and have noticed a discrepancy in the
> environment variable names for the LDAP options. The manpage & sample autofs
> file have
> 
> DEFAULT_MAP_OBJECT_CLASS, DEFAULT_ENTRY_OBJECT_CLASS, DEFAULT_MAP_ATTRIBUTE,
> DEFAULT_ENTRY_ATTRIBUTE, DEFAULT_VALUE_ATTRIBUTE
> 
> but in lib/defaults.c (lines 35-39) they are
> 
> #define ENV_NAME_MAP_OBJ_CLASS          "DEFAULT_MAP_OBJ_CLASS"
> #define ENV_NAME_ENTRY_OBJ_CLASS        "DEFAULT_ENTRY_OBJ_CLASS"
> #define ENV_NAME_MAP_ATTR               "DEFAULT_MAP_ATTR"
> #define ENV_NAME_ENTRY_ATTR             "DEFAULT_ENTRY_ATTR"
> #define ENV_NAME_VALUE_ATTR             "DEFAULT_VALUE_ATTR"

Oops.

There are a couple of other patches on kernel.org for beta4 already.
You may need them as well.
I've put a patch for this on kernel.org also.

My CVS tree and the git autofs repo on kernel.org have all current 
patches.

Ian
