// RUN: llvm-mc -triple x86_64 --show-encoding %s | FileCheck %s

// CHECK: vcomxsd %xmm23, %xmm22
// CHECK: encoding: [0x62,0xa1,0xff,0x08,0x2f,0xf7]
          vcomxsd %xmm23, %xmm22

// CHECK: vcomxsd {sae}, %xmm23, %xmm22
// CHECK: encoding: [0x62,0xa1,0xff,0x18,0x2f,0xf7]
          vcomxsd {sae}, %xmm23, %xmm22

// CHECK: vcomxsd  268435456(%rbp,%r14,8), %xmm22
// CHECK: encoding: [0x62,0xa1,0xff,0x08,0x2f,0xb4,0xf5,0x00,0x00,0x00,0x10]
          vcomxsd  268435456(%rbp,%r14,8), %xmm22

// CHECK: vcomxsd  291(%r8,%rax,4), %xmm22
// CHECK: encoding: [0x62,0xc1,0xff,0x08,0x2f,0xb4,0x80,0x23,0x01,0x00,0x00]
          vcomxsd  291(%r8,%rax,4), %xmm22

// CHECK: vcomxsd  (%rip), %xmm22
// CHECK: encoding: [0x62,0xe1,0xff,0x08,0x2f,0x35,0x00,0x00,0x00,0x00]
          vcomxsd  (%rip), %xmm22

// CHECK: vcomxsd  -256(,%rbp,2), %xmm22
// CHECK: encoding: [0x62,0xe1,0xff,0x08,0x2f,0x34,0x6d,0x00,0xff,0xff,0xff]
          vcomxsd  -256(,%rbp,2), %xmm22

// CHECK: vcomxsd  1016(%rcx), %xmm22
// CHECK: encoding: [0x62,0xe1,0xff,0x08,0x2f,0x71,0x7f]
          vcomxsd  1016(%rcx), %xmm22

// CHECK: vcomxsd  -1024(%rdx), %xmm22
// CHECK: encoding: [0x62,0xe1,0xff,0x08,0x2f,0x72,0x80]
          vcomxsd  -1024(%rdx), %xmm22

// CHECK: vcomxsh %xmm23, %xmm22
// CHECK: encoding: [0x62,0xa5,0x7e,0x08,0x2f,0xf7]
          vcomxsh %xmm23, %xmm22

// CHECK: vcomxsh {sae}, %xmm23, %xmm22
// CHECK: encoding: [0x62,0xa5,0x7e,0x18,0x2f,0xf7]
          vcomxsh {sae}, %xmm23, %xmm22

// CHECK: vcomxsh  268435456(%rbp,%r14,8), %xmm22
// CHECK: encoding: [0x62,0xa5,0x7e,0x08,0x2f,0xb4,0xf5,0x00,0x00,0x00,0x10]
          vcomxsh  268435456(%rbp,%r14,8), %xmm22

// CHECK: vcomxsh  291(%r8,%rax,4), %xmm22
// CHECK: encoding: [0x62,0xc5,0x7e,0x08,0x2f,0xb4,0x80,0x23,0x01,0x00,0x00]
          vcomxsh  291(%r8,%rax,4), %xmm22

// CHECK: vcomxsh  (%rip), %xmm22
// CHECK: encoding: [0x62,0xe5,0x7e,0x08,0x2f,0x35,0x00,0x00,0x00,0x00]
          vcomxsh  (%rip), %xmm22

// CHECK: vcomxsh  -64(,%rbp,2), %xmm22
// CHECK: encoding: [0x62,0xe5,0x7e,0x08,0x2f,0x34,0x6d,0xc0,0xff,0xff,0xff]
          vcomxsh  -64(,%rbp,2), %xmm22

// CHECK: vcomxsh  254(%rcx), %xmm22
// CHECK: encoding: [0x62,0xe5,0x7e,0x08,0x2f,0x71,0x7f]
          vcomxsh  254(%rcx), %xmm22

// CHECK: vcomxsh  -256(%rdx), %xmm22
// CHECK: encoding: [0x62,0xe5,0x7e,0x08,0x2f,0x72,0x80]
          vcomxsh  -256(%rdx), %xmm22

// CHECK: vcomxss %xmm23, %xmm22
// CHECK: encoding: [0x62,0xa1,0x7e,0x08,0x2f,0xf7]
          vcomxss %xmm23, %xmm22

// CHECK: vcomxss {sae}, %xmm23, %xmm22
// CHECK: encoding: [0x62,0xa1,0x7e,0x18,0x2f,0xf7]
          vcomxss {sae}, %xmm23, %xmm22

// CHECK: vcomxss  268435456(%rbp,%r14,8), %xmm22
// CHECK: encoding: [0x62,0xa1,0x7e,0x08,0x2f,0xb4,0xf5,0x00,0x00,0x00,0x10]
          vcomxss  268435456(%rbp,%r14,8), %xmm22

// CHECK: vcomxss  291(%r8,%rax,4), %xmm22
// CHECK: encoding: [0x62,0xc1,0x7e,0x08,0x2f,0xb4,0x80,0x23,0x01,0x00,0x00]
          vcomxss  291(%r8,%rax,4), %xmm22

// CHECK: vcomxss  (%rip), %xmm22
// CHECK: encoding: [0x62,0xe1,0x7e,0x08,0x2f,0x35,0x00,0x00,0x00,0x00]
          vcomxss  (%rip), %xmm22

// CHECK: vcomxss  -128(,%rbp,2), %xmm22
// CHECK: encoding: [0x62,0xe1,0x7e,0x08,0x2f,0x34,0x6d,0x80,0xff,0xff,0xff]
          vcomxss  -128(,%rbp,2), %xmm22

// CHECK: vcomxss  508(%rcx), %xmm22
// CHECK: encoding: [0x62,0xe1,0x7e,0x08,0x2f,0x71,0x7f]
          vcomxss  508(%rcx), %xmm22

// CHECK: vcomxss  -512(%rdx), %xmm22
// CHECK: encoding: [0x62,0xe1,0x7e,0x08,0x2f,0x72,0x80]
          vcomxss  -512(%rdx), %xmm22

// CHECK: vucomxsd %xmm23, %xmm22
// CHECK: encoding: [0x62,0xa1,0xff,0x08,0x2e,0xf7]
          vucomxsd %xmm23, %xmm22

// CHECK: vucomxsd {sae}, %xmm23, %xmm22
// CHECK: encoding: [0x62,0xa1,0xff,0x18,0x2e,0xf7]
          vucomxsd {sae}, %xmm23, %xmm22

// CHECK: vucomxsd  268435456(%rbp,%r14,8), %xmm22
// CHECK: encoding: [0x62,0xa1,0xff,0x08,0x2e,0xb4,0xf5,0x00,0x00,0x00,0x10]
          vucomxsd  268435456(%rbp,%r14,8), %xmm22

// CHECK: vucomxsd  291(%r8,%rax,4), %xmm22
// CHECK: encoding: [0x62,0xc1,0xff,0x08,0x2e,0xb4,0x80,0x23,0x01,0x00,0x00]
          vucomxsd  291(%r8,%rax,4), %xmm22

// CHECK: vucomxsd  (%rip), %xmm22
// CHECK: encoding: [0x62,0xe1,0xff,0x08,0x2e,0x35,0x00,0x00,0x00,0x00]
          vucomxsd  (%rip), %xmm22

// CHECK: vucomxsd  -256(,%rbp,2), %xmm22
// CHECK: encoding: [0x62,0xe1,0xff,0x08,0x2e,0x34,0x6d,0x00,0xff,0xff,0xff]
          vucomxsd  -256(,%rbp,2), %xmm22

// CHECK: vucomxsd  1016(%rcx), %xmm22
// CHECK: encoding: [0x62,0xe1,0xff,0x08,0x2e,0x71,0x7f]
          vucomxsd  1016(%rcx), %xmm22

// CHECK: vucomxsd  -1024(%rdx), %xmm22
// CHECK: encoding: [0x62,0xe1,0xff,0x08,0x2e,0x72,0x80]
          vucomxsd  -1024(%rdx), %xmm22

// CHECK: vucomxsh %xmm23, %xmm22
// CHECK: encoding: [0x62,0xa5,0x7e,0x08,0x2e,0xf7]
          vucomxsh %xmm23, %xmm22

// CHECK: vucomxsh {sae}, %xmm23, %xmm22
// CHECK: encoding: [0x62,0xa5,0x7e,0x18,0x2e,0xf7]
          vucomxsh {sae}, %xmm23, %xmm22

// CHECK: vucomxsh  268435456(%rbp,%r14,8), %xmm22
// CHECK: encoding: [0x62,0xa5,0x7e,0x08,0x2e,0xb4,0xf5,0x00,0x00,0x00,0x10]
          vucomxsh  268435456(%rbp,%r14,8), %xmm22

// CHECK: vucomxsh  291(%r8,%rax,4), %xmm22
// CHECK: encoding: [0x62,0xc5,0x7e,0x08,0x2e,0xb4,0x80,0x23,0x01,0x00,0x00]
          vucomxsh  291(%r8,%rax,4), %xmm22

// CHECK: vucomxsh  (%rip), %xmm22
// CHECK: encoding: [0x62,0xe5,0x7e,0x08,0x2e,0x35,0x00,0x00,0x00,0x00]
          vucomxsh  (%rip), %xmm22

// CHECK: vucomxsh  -64(,%rbp,2), %xmm22
// CHECK: encoding: [0x62,0xe5,0x7e,0x08,0x2e,0x34,0x6d,0xc0,0xff,0xff,0xff]
          vucomxsh  -64(,%rbp,2), %xmm22

// CHECK: vucomxsh  254(%rcx), %xmm22
// CHECK: encoding: [0x62,0xe5,0x7e,0x08,0x2e,0x71,0x7f]
          vucomxsh  254(%rcx), %xmm22

// CHECK: vucomxsh  -256(%rdx), %xmm22
// CHECK: encoding: [0x62,0xe5,0x7e,0x08,0x2e,0x72,0x80]
          vucomxsh  -256(%rdx), %xmm22

// CHECK: vucomxss %xmm23, %xmm22
// CHECK: encoding: [0x62,0xa1,0x7e,0x08,0x2e,0xf7]
          vucomxss %xmm23, %xmm22

// CHECK: vucomxss {sae}, %xmm23, %xmm22
// CHECK: encoding: [0x62,0xa1,0x7e,0x18,0x2e,0xf7]
          vucomxss {sae}, %xmm23, %xmm22

// CHECK: vucomxss  268435456(%rbp,%r14,8), %xmm22
// CHECK: encoding: [0x62,0xa1,0x7e,0x08,0x2e,0xb4,0xf5,0x00,0x00,0x00,0x10]
          vucomxss  268435456(%rbp,%r14,8), %xmm22

// CHECK: vucomxss  291(%r8,%rax,4), %xmm22
// CHECK: encoding: [0x62,0xc1,0x7e,0x08,0x2e,0xb4,0x80,0x23,0x01,0x00,0x00]
          vucomxss  291(%r8,%rax,4), %xmm22

// CHECK: vucomxss  (%rip), %xmm22
// CHECK: encoding: [0x62,0xe1,0x7e,0x08,0x2e,0x35,0x00,0x00,0x00,0x00]
          vucomxss  (%rip), %xmm22

// CHECK: vucomxss  -128(,%rbp,2), %xmm22
// CHECK: encoding: [0x62,0xe1,0x7e,0x08,0x2e,0x34,0x6d,0x80,0xff,0xff,0xff]
          vucomxss  -128(,%rbp,2), %xmm22

// CHECK: vucomxss  508(%rcx), %xmm22
// CHECK: encoding: [0x62,0xe1,0x7e,0x08,0x2e,0x71,0x7f]
          vucomxss  508(%rcx), %xmm22

// CHECK: vucomxss  -512(%rdx), %xmm22
// CHECK: encoding: [0x62,0xe1,0x7e,0x08,0x2e,0x72,0x80]
          vucomxss  -512(%rdx), %xmm22

