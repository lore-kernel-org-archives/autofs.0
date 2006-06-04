From: jpro@bas.ac.uk
Subject: Re: [ANNOUNCE] autofs 5.0.0 beta4 another beta release
Date: Sun, 4 Jun 2006 22:28:08 +0100 (BST)
Message-ID: <Pine.LNX.4.63.0606042223580.12192@jpro.nerc-bas.ac.uk>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Hi,

> I think we are getting close to a release but we need more testing in 
> more areas on this or we will be stuck with annoying bugs in the v5 
> release for longer than we should.

I've just started looking at autofs v5 and have noticed a discrepancy 
in the environment variable names for the LDAP options. The manpage & 
sample autofs file have

DEFAULT_MAP_OBJECT_CLASS, DEFAULT_ENTRY_OBJECT_CLASS, 
DEFAULT_MAP_ATTRIBUTE, DEFAULT_ENTRY_ATTRIBUTE, DEFAULT_VALUE_ATTRIBUTE

but in lib/defaults.c (lines 35-39) they are

#define ENV_NAME_MAP_OBJ_CLASS          "DEFAULT_MAP_OBJ_CLASS"
#define ENV_NAME_ENTRY_OBJ_CLASS        "DEFAULT_ENTRY_OBJ_CLASS"
#define ENV_NAME_MAP_ATTR               "DEFAULT_MAP_ATTR"
#define ENV_NAME_ENTRY_ATTR             "DEFAULT_ENTRY_ATTR"
#define ENV_NAME_VALUE_ATTR             "DEFAULT_VALUE_ATTR"

Jeremy
-- 
jpro@bas.ac.uk | (work) 01223 221402 (fax) 01223 362616
Unix System Administrator - British Antarctic Survey
#include <disclaimer.std>

--  
This message (and any attachments) is for the recipient only.  NERC is subject
to the Freedom of Information Act 2000 and the contents of this email and any
reply you make may be disclosed by NERC unless it is exempt from release under
the Act.  Any material supplied to NERC may be stored in an electronic
records management system.
