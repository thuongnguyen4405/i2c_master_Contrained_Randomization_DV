#!/usr/bin/env bash
# School environment on screenshot called setup_dva; optional in public repo.
if command -v setup_dva >/dev/null 2>&1; then
    setup_dva
else
    echo "[INFO] setup_dva not found; configure licensed Questa on PATH."
fi
